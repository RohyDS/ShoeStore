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
import com.chaussures.services.EvenementsPromosService;
import com.chaussures.models.Remise;
import com.chaussures.models.EvenementsPromos;

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

    @Autowired
    private EvenementsPromosService evenementsPromosService;

    @PostMapping("/simuler-date")
    public String simulerDate(@RequestParam("simulatedDate") String dateStr, HttpSession session) {
        if (dateStr == null || dateStr.isEmpty()) {
            session.removeAttribute("simulatedDate");
            session.removeAttribute("simulatedDateStr");
        } else {
            try {
                session.setAttribute("simulatedDate", LocalDateTime.parse(dateStr));
                session.setAttribute("simulatedDateStr", dateStr);
            } catch (Exception e) {
                // En cas d'erreur de parsing, on ignore
            }
        }
        String lastPage = (String) session.getAttribute("lastPage");
        return "redirect:" + (lastPage != null ? lastPage : "/clientAffichage/accueil");
    }

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
        
        session.setAttribute("lastPage", "/clientAffichage/accueil");
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) {
            return "redirect:/clientAffichage/login";
        }

        Page<ChaussuresCouleurPointure> variantesPage = varianteService.findWithFilters(
                nom, categorieId, genreId, couleurId, pointureId, PageRequest.of(page, size));

        model.addAttribute("variantes", variantesPage.getContent());
        
        // Promotions actives pour la date simulée
        LocalDateTime now = (LocalDateTime) session.getAttribute("simulatedDate");
        if (now == null) now = LocalDateTime.now();
        List<EvenementsPromos> activePromos = evenementsPromosService.getActivePromos(now);
        Map<Integer, EvenementsPromos> promoMap = new HashMap<>();
        for (EvenementsPromos promo : activePromos) {
            promoMap.put(promo.getChaussureGenre().getId(), promo);
        }
        model.addAttribute("promoMap", promoMap);
        
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
        session.setAttribute("lastPage", "/clientAffichage/panier");
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
        updateAllRemises(panier, session);

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
        session.setAttribute("lastPage", "/clientAffichage/commandes");
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
                newItem.setIdChaussureGenre(variante.getChaussureGenre().getId());
                
                panier.add(newItem);
            }
            
            // Recalculer les remises pour tout le panier car la quantité totale a changé
            updateAllRemises(panier, session);
            
            return "redirect:/clientAffichage/accueil?added=true";
        }
        return "redirect:/clientAffichage/accueil?error=true";
    }

    @PostMapping("/commande/retourner")
    public String retournerArticle(@RequestParam Integer idCd, @RequestParam Integer quantite, @RequestParam(required = false) String motif, HttpSession session) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        if (loggedInClient == null) return "redirect:/clientAffichage/login";

        try {
            retourService.effectuerRetour(idCd, quantite, motif);
            return "redirect:/clientAffichage/commandes?returned=true";
        } catch (Exception e) {
            return "redirect:/clientAffichage/commandes?error=" + e.getMessage();
        }
    }

    private void updateAllRemises(List<PanierItem> panier, HttpSession session) {
        if (panier == null || panier.isEmpty()) return;
        
        // 0. Réinitialiser les remises spéciales
        for (PanierItem item : panier) {
            item.setRemiseSpecialePourcentage(0.0);
            item.setRemiseSpecialeNom(null);
            item.setQuantiteRemiseeSpeciale(0);
        }

        // 1. Appliquer les événements promotionnels (ex: Saint Valentin)
        LocalDateTime now = (LocalDateTime) session.getAttribute("simulatedDate");
        if (now == null) now = LocalDateTime.now();
        
        List<EvenementsPromos> activePromos = evenementsPromosService.getActivePromos(now);
        if (!activePromos.isEmpty()) {
            // Pour la Saint Valentin : 2 articles au choix (les plus chers)
            int articlesRestantsPromo = 2;
            
            // Trier les articles par prix décroissant pour favoriser le client
            List<PanierItem> itemsTries = new ArrayList<>(panier);
            itemsTries.sort((a, b) -> b.getPrixUnitaire().compareTo(a.getPrixUnitaire()));
            
            for (PanierItem item : itemsTries) {
                if (articlesRestantsPromo <= 0) break;
                
                // Vérifier si cet item fait partie d'une promo active
                for (EvenementsPromos promo : activePromos) {
                    if (item.getIdChaussureGenre().equals(promo.getChaussureGenre().getId())) {
                        int quantiteAAppliquer = Math.min(item.getQuantite(), articlesRestantsPromo);
                        item.setRemiseSpecialePourcentage(promo.getRemise());
                        item.setRemiseSpecialeNom(promo.getNom());
                        item.setQuantiteRemiseeSpeciale(quantiteAAppliquer);
                        articlesRestantsPromo -= quantiteAAppliquer;
                        break;
                    }
                }
            }
        }

        int totalQuantite = panier.stream().mapToInt(PanierItem::getQuantite).sum();
        
        // 2. Règle Globale : Récupérée dynamiquement depuis la base de données
        double remiseGlobale = remiseService.findApplicableRemise(totalQuantite)
                                .map(r -> r.getRemise())
                                .orElse(0.0);

        for (PanierItem item : panier) {
            // 3. Règle de Ligne : Récupérée dynamiquement pour la quantité de la ligne
            double remiseLigne = remiseService.findApplicableRemise(item.getQuantite())
                                    .map(r -> r.getRemise())
                                    .orElse(0.0);
            item.setRemiseLignePourcentage(remiseLigne);
            
            // 4. Calcul du prix final avec remises successives
            // a. Remise spéciale (prioritaire sur une partie de la quantité)
            BigDecimal totalItem = BigDecimal.ZERO;
            int qSpeciale = item.getQuantiteRemiseeSpeciale() != null ? item.getQuantiteRemiseeSpeciale() : 0;
            int qNormale = item.getQuantite() - qSpeciale;
            
            // Calcul pour la partie avec remise spéciale
            if (qSpeciale > 0) {
                BigDecimal prixSpeciale = item.getPrixUnitaire().multiply(new BigDecimal(1 - item.getRemiseSpecialePourcentage() / 100.0));
                totalItem = totalItem.add(prixSpeciale.multiply(new BigDecimal(qSpeciale)));
            }
            
            // Calcul pour la partie normale (remise ligne puis globale)
            if (qNormale > 0) {
                BigDecimal prixApresLigne = item.getPrixUnitaire();
                if (remiseLigne > 0) {
                    prixApresLigne = item.getPrixUnitaire().multiply(new BigDecimal(1 - remiseLigne / 100.0));
                }
                
                BigDecimal prixFinalNormale = prixApresLigne;
                if (remiseGlobale > 0) {
                    prixFinalNormale = prixApresLigne.multiply(new BigDecimal(1 - remiseGlobale / 100.0));
                }
                totalItem = totalItem.add(prixFinalNormale.multiply(new BigDecimal(qNormale)));
            }
            
            // Prix moyen après toutes les remises pour cet item
            BigDecimal prixMoyenFinal = totalItem.divide(new BigDecimal(item.getQuantite()), 2, BigDecimal.ROUND_HALF_UP);
            
            // Calcul du pourcentage total d'économie
            BigDecimal totalSansRemise = item.getPrixUnitaire().multiply(new BigDecimal(item.getQuantite()));
            if (totalItem.compareTo(totalSansRemise) < 0) {
                BigDecimal economie = totalSansRemise.subtract(totalItem);
                double pourcentageTotal = economie.divide(totalSansRemise, 4, BigDecimal.ROUND_HALF_UP)
                                            .multiply(new BigDecimal(100)).doubleValue();
                
                item.setRemisePourcentage(pourcentageTotal);
                item.setPrixRemise(prixMoyenFinal);
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
            updateAllRemises(panier, session);
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
        
        // Utiliser la date simulée si présente
        LocalDateTime now = (LocalDateTime) session.getAttribute("simulatedDate");
        if (now == null) now = LocalDateTime.now();
        commande.setDateCommande(now);
        
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
                mvtStock.setDateMvt(now);
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
