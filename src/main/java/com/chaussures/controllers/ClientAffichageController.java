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
import com.chaussures.repositories.StockRepository;
import com.chaussures.services.CategoriesService;
import com.chaussures.services.ChaussuresCouleurPointureService;
import com.chaussures.services.ClientsService;
import com.chaussures.services.CommandesDetailsService;
import com.chaussures.services.CommandesService;
import com.chaussures.services.CouleurService;
import com.chaussures.services.GenreService;
import com.chaussures.services.PointureService;

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
    private StockRepository stockRepository;

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

        BigDecimal total = panier.stream()
                .map(PanierItem::getTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("panier", panier);
        model.addAttribute("total", total);
        model.addAttribute("client", loggedInClient);
        return "client_affichage/panier";
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
                PanierItem newItem = new PanierItem(
                    varianteId,
                    variante.getChaussureGenre().getChaussure().getNom(),
                    variante.getChaussureGenre().getCategories().getNom(),
                    variante.getChaussureGenre().getGenre().getNom(),
                    variante.getCouleur().getNom(),
                    variante.getPointure().getNom(),
                    quantite,
                    variante.getPrix()
                );
                panier.add(newItem);
            }
            return "redirect:/clientAffichage/accueil?added=true";
        }
        return "redirect:/clientAffichage/accueil?error=true";
    }

    @GetMapping("/panier/supprimer/{varianteId}")
    public String supprimerDuPanier(@PathVariable Integer varianteId, HttpSession session) {
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");
        if (panier != null) {
            panier.removeIf(item -> item.getVarianteId().equals(varianteId));
        }
        return "redirect:/clientAffichage/panier";
    }

    @PostMapping("/panier/valider")
    public String validerPanier(HttpSession session) {
        Clients loggedInClient = (Clients) session.getAttribute("loggedInClient");
        List<PanierItem> panier = (List<PanierItem>) session.getAttribute("panier");

        if (loggedInClient == null) return "redirect:/clientAffichage/login";
        if (panier == null || panier.isEmpty()) return "redirect:/clientAffichage/accueil";

        // Créer la commande
        Commandes commande = new Commandes();
        commande.setClient(loggedInClient);
        commande.setDateCommande(LocalDateTime.now());
        commande = commandesService.save(commande);

        // Créer les détails
        for (PanierItem item : panier) {
            ChaussuresCouleurPointure variante = varianteService.findById(item.getVarianteId()).orElse(null);
            if (variante != null) {
                CommandesDetails detail = new CommandesDetails();
                detail.setCommande(commande);
                detail.setChaussuresCouleurPointure(variante);
                detail.setQuantite(item.getQuantite());
                detail.setPrix(item.getPrix());
                commandesDetailsService.save(detail);
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
