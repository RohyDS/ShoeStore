package com.chaussures.controllers;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chaussures.models.ChaussuresCouleurPointure;
import com.chaussures.models.Clients;
import com.chaussures.models.Commandes;
import com.chaussures.models.CommandesDetails;
import com.chaussures.models.PanierItem;
import com.chaussures.models.Stock;
import com.chaussures.models.TypeMvtStock;
import com.chaussures.repositories.StockRepository;
import com.chaussures.services.CategoriesService;
import com.chaussures.services.ChaussuresCouleurPointureService;
import com.chaussures.services.ClientsService;
import com.chaussures.services.CommandesDetailsService;
import com.chaussures.services.CommandesService;
import com.chaussures.services.CouleurService;
import com.chaussures.services.GenreService;
import com.chaussures.services.PointureService;
import com.chaussures.services.RemiseService;
import com.chaussures.services.StockService;
import com.chaussures.services.TypeMvtStockService;
import com.chaussures.services.LieuService;
import com.chaussures.services.FraisLivraisonService;
import com.chaussures.services.RetourService;
import com.chaussures.models.Remise;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clientAffichage")
public class ClientAffichageController {

    @Autowired
    private ClientsService clientsService;

    @Autowired
    private ChaussuresCouleurPointureService varianteService;

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private GenreService genreService;

    @Autowired
    private CouleurService couleurService;

    @Autowired
    private PointureService pointureService;

    @Autowired
    private CommandesService commandesService;

    @Autowired
    private CommandesDetailsService commandesDetailsService;

    @Autowired
    private StockService stockService;

    @Autowired
    private TypeMvtStockService typeMvtStockService;

    @Autowired
    private RemiseService remiseService;

    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private LieuService lieuService;

    @Autowired
    private FraisLivraisonService fraisLivraisonService;

    @Autowired
    private RetourService retourService;

    @GetMapping
    public String index() {
        return "redirect:/clientAffichage/login";
    }

    @GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("clients", clientsService.findAll());
        return "client_affichage/login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam Integer clientId, HttpSession session) {
        Clients client = clientsService.findById(clientId).orElse(null);
        if (client != null) {
            session.setAttribute("loggedInClient", client);
            return "redirect:/clientAffichage/accueil";
        }
        return "redirect:/clientAffichage/login?error=true";
    }

    @GetMapping("/accueil")
    public String accueil(
            @RequestParam(required = false) String nom,
            @RequestParam(required = false) Integer categorieId,
            @RequestParam(required = false) Integer genreId,
            @RequestParam(required = false) Integer couleurId,
            @RequestParam(required = false) Integer pointureId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            HttpSession session,
            Model model) {
        
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) {
            return "redirect:/clientAffichage/login";
        }

        Page<ChaussuresCouleurPointure> variantesPage = varianteService.findWithFilters(
                nom, categorieId, genreId, couleurId, pointureId, PageRequest.of(page, size));

        model.addAttribute("variantes", variantesPage.getContent());
        
        // Calculer le stock pour chaque variante
        Map<Integer, Integer> stocks = new HashMap<>();
        for (ChaussuresCouleurPointure v : variantesPage.getContent()) {
            stocks.put(v.getId(), stockRepository.getStockByVarianteId(v.getId()));
        }
        model.addAttribute("stocks", stocks);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", variantesPage.getTotalPages());
        model.addAttribute("totalItems", variantesPage.getTotalElements());
        
        model.addAttribute("categories", categoriesService.findAll());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("couleurs", couleurService.findAll());
        model.addAttribute("pointures", pointureService.findAll());
        
        model.addAttribute("nom", nom);
        model.addAttribute("categorieId", categorieId);
        model.addAttribute("genreId", genreId);
        model.addAttribute("couleurId", couleurId);
        model.addAttribute("pointureId", pointureId);
        
        model.addAttribute("client", loggedInClient);
        
        // Récupérer le panier pour afficher le nombre d'articles
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        model.addAttribute("panierCount", panier != null ? panier.stream().mapToInt(PanierItem::getQuantite).sum() : 0);
        
        return "client_affichage/accueil";
    }

    @GetMapping("/panier")
    public String voirPanier(HttpSession session, Model model) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) return "redirect:/clientAffichage/login";

        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        if (panier == null) panier = new ArrayList<>();

        // Calculer la quantité totale pour la remise globale
        int totalQuantite = panier.stream().mapToInt(PanierItem::getQuantite).sum();
        
        // Trouver la remise applicable sur le total
        final Double remiseGlobale = remiseService.findApplicableRemise(totalQuantite)
                .map(Remise::getRemise)
                .orElse(null);

        // Appliquer la remise à chaque item (en distinguant remise ligne et remise globale)
        updateAllRemises(panier);

        BigDecimal total = panier.stream()
                .map(PanierItem::getTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("panier", panier);
        model.addAttribute("total", total);
        model.addAttribute("remiseGlobale", (remiseGlobale != null && remiseGlobale > 0) ? remiseGlobale : null);
        model.addAttribute("client", loggedInClient);
        
        // Ajouter les lieux et leurs frais pour le choix de livraison
        model.addAttribute("lieux", lieuService.findAll());
        Map<Integer, BigDecimal> fraisMap = new HashMap<>();
        lieuService.findAll().forEach(l -> {
            fraisMap.put(l.getId(), fraisLivraisonService.getFraisActuel(l.getId()));
        });
        model.addAttribute("fraisMap", fraisMap);

        return "client_affichage/panier";
    }

    @GetMapping("/commandes")
    public String mesCommandes(HttpSession session, Model model) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) return "redirect:/clientAffichage/login";

        List<Commandes> commandes = commandesService.findByClientId(loggedInClient.getId());
        model.addAttribute("commandes", commandes);
        model.addAttribute("client", loggedInClient);
        
        // Récupérer le panier pour afficher le nombre d'articles
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        model.addAttribute("panierCount", panier != null ? panier.stream().mapToInt(PanierItem::getQuantite).sum() : 0);
        
        // Ajouter les frais pour l'affichage des totaux
        Map<Integer, BigDecimal> fraisMap = new HashMap<>();
        lieuService.findAll().forEach(l -> {
            fraisMap.put(l.getId(), fraisLivraisonService.getFraisActuel(l.getId()));
        });
        model.addAttribute("fraisMap", fraisMap);
        
        return "client_affichage/commandes";
    }

    @PostMapping("/panier/ajouter")
    public String ajouterAuPanier(@RequestParam Integer varianteId, @RequestParam Integer quantite, HttpSession session) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) return "redirect:/clientAffichage/login";

        ChaussuresCouleurPointure variante = varianteService.findById(varianteId).orElse(null);
        if (variante != null && quantite > 0) {
            // Vérification du stock
            Integer stockDisponible = stockRepository.getStockByVarianteId(varianteId);
            
            List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
            if (panier == null) {
                panier = new ArrayList<>();
                session.setAttribute("panier", panier);
            }

            // Calculer la quantité déjà dans le panier pour cette variante
            int quantiteDansPanier = panier.stream()
                    .filter(item -> item.getVarianteId().equals(varianteId))
                    .mapToInt(PanierItem::getQuantite)
                    .sum();

            if (stockDisponible < (quantiteDansPanier + quantite)) {
                return "redirect:/clientAffichage/accueil?error=stock&available=" + stockDisponible;
            }

            // Vérifier si l'article est déjà dans le panier
            boolean found = false;
            for (PanierItem item : panier) {
                if (item.getVarianteId().equals(varianteId)) {
                    item.setQuantite(item.getQuantite() + quantite);
                    found = true;
                    break;
                }
            }

            if (!found) {
                PanierItem newItem = new PanierItem();
                newItem.setVarianteId(varianteId);
                newItem.setNom(variante.getChaussureGenre().getChaussure().getNom());
                newItem.setCategorie(variante.getChaussureGenre().getCategories().getNom());
                newItem.setGenre(variante.getChaussureGenre().getGenre().getNom());
                newItem.setCouleur(variante.getCouleur().getNom());
                newItem.setPointure(variante.getPointure().getNom());
                newItem.setQuantite(quantite);
                newItem.setPrixUnitaire(variante.getPrixEffectif());
                
                panier.add(newItem);
            }
            
            // Recalculer les remises pour tout le panier car la quantité totale a changé
            updateAllRemises(panier);
            
            return "redirect:/clientAffichage/accueil?added=true";
        }
        return "redirect:/clientAffichage/accueil?error=true";
    }

    @PostMapping("/commande/retourner")
    public String retournerArticle(@RequestParam Integer idCd, @RequestParam Integer quantite, HttpSession session) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) return "redirect:/clientAffichage/login";

        try {
            retourService.effectuerRetour(idCd, quantite);
            return "redirect:/clientAffichage/commandes?returned=true";
        } catch (Exception e) {
            return "redirect:/clientAffichage/commandes?error=" + e.getMessage();
        }
    }

    private void updateAllRemises(List<PanierItem> panier) {
        if (panier == null || panier.isEmpty()) return;
        
        int totalQuantite = panier.stream().mapToInt(PanierItem::getQuantite).sum();
        
        // 1. Règle Globale : 20% si quantité totale > 5
        double remiseGlobale = (totalQuantite > 5) ? 20.0 : 0.0;

        for (PanierItem item : panier) {
            // 2. Règle de Ligne : 10% si quantité ligne > 1
            double remiseLigne = (item.getQuantite() > 1) ? 10.0 : 0.0;
            item.setRemiseLignePourcentage(remiseLigne);
            
            // 3. Calcul de la remise effective (Successive : 10% puis 20% sur le reste)
            // On calcule le prix après remise de ligne, puis on applique la globale
            BigDecimal prixApresLigne = item.getPrixUnitaire();
            if (remiseLigne > 0) {
                BigDecimal reductionLigne = item.getPrixUnitaire().multiply(new BigDecimal(remiseLigne / 100.0));
                prixApresLigne = item.getPrixUnitaire().subtract(reductionLigne);
            }
            
            BigDecimal prixFinal = prixApresLigne;
            if (remiseGlobale > 0) {
                BigDecimal reductionGlobale = prixApresLigne.multiply(new BigDecimal(remiseGlobale / 100.0));
                prixFinal = prixApresLigne.subtract(reductionGlobale);
            }
            
            // Calcul du pourcentage total équivalent pour l'affichage
            if (prixFinal.compareTo(item.getPrixUnitaire()) < 0) {
                BigDecimal totalEconomie = item.getPrixUnitaire().subtract(prixFinal);
                double pourcentageTotal = totalEconomie.divide(item.getPrixUnitaire(), 4, BigDecimal.ROUND_HALF_UP)
                                            .multiply(new BigDecimal(100)).doubleValue();
                
                item.setRemisePourcentage(pourcentageTotal);
                item.setPrixRemise(prixFinal);
            } else {
                item.setRemisePourcentage(null);
                item.setPrixRemise(null);
            }
        }
    }

    @GetMapping("/panier/supprimer/{varianteId}")
    public String supprimerDuPanier(@PathVariable Integer varianteId, HttpSession session) {
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        if (panier != null) {
            panier.removeIf(item -> item.getVarianteId().equals(varianteId));
            // Recalculer les remises après suppression
            updateAllRemises(panier);
        }
        return "redirect:/clientAffichage/panier";
    }

    @PostMapping("/panier/updateLieu")
    public String updateLieu(@RequestParam Integer varianteId, @RequestParam Integer lieuId, HttpSession session) {
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        if (panier != null) {
            for (PanierItem item : panier) {
                if (item.getVarianteId().equals(varianteId)) {
                    item.setLieuId(lieuId);
                    break;
                }
            }
        }
        return "redirect:/clientAffichage/panier";
    }

    @PostMapping("/panier/valider")
    @Transactional
    public String validerPanier(HttpSession session) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");

        if (loggedInClient == null) return "redirect:/clientAffichage/login";
        if (panier == null || panier.isEmpty()) return "redirect:/clientAffichage/accueil";

        // Récupérer le type de mouvement "Sortie" (ID 2)
        TypeMvtStock typeSortie = typeMvtStockService.findById(2).orElse(null);

        // Créer la commande
        Commandes commande = new Commandes();
        commande.setClient(loggedInClient);
        commande.setDateCommande(LocalDateTime.now());
        
        commande = commandesService.save(commande);

        // Créer les détails et mouvements de stock
        for (PanierItem item : panier) {
            ChaussuresCouleurPointure variante = varianteService.findById(item.getVarianteId()).orElse(null);
            if (variante != null) {
                // 1. Enregistrer le détail de la commande
                CommandesDetails detail = new CommandesDetails();
                detail.setCommande(commande);
                detail.setChaussuresCouleurPointure(variante);
                detail.setQuantite(item.getQuantite());
                detail.setPrix(item.getPrixRemise() != null ? item.getPrixRemise() : item.getPrixUnitaire());
                
                if (item.getLieuId() != null) {
                    lieuService.findById(item.getLieuId()).ifPresent(detail::setLieu);
                }

                commandesDetailsService.save(detail);

                // 2. Enregistrer le mouvement de stock (Sortie)
                Stock mvtStock = new Stock();
                mvtStock.setChaussuresCouleurPointure(variante);
                mvtStock.setTypeMvtStock(typeSortie);
                mvtStock.setQuantite(-item.getQuantite()); // Quantité négative pour une sortie
                mvtStock.setDateMvt(LocalDateTime.now());
                stockService.save(mvtStock);
            }
        }

        // Vider le panier
        session.removeAttribute("panier");

        return "redirect:/clientAffichage/accueil?success=true";
    }

    @PostMapping("/commander")
    @Deprecated
    public String commander(@RequestParam Integer varianteId, @RequestParam Integer quantite, HttpSession session) {
        return ajouterAuPanier(varianteId, quantite, session);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/clientAffichage/login";
    }
}
