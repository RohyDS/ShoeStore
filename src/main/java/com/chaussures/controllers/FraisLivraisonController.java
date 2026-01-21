package com.chaussures.controllers;

import com.chaussures.models.FraisLivraison;
import com.chaussures.services.FraisLivraisonService;
import com.chaussures.services.LieuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/frais-livraison")
public class FraisLivraisonController {
    @Autowired private FraisLivraisonService service;
    @Autowired private LieuService lieuService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "fraisLivraison");
        model.addAttribute("items", service.findAll());
        return "frais_livraison/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "fraisLivraison");
        model.addAttribute("item", new FraisLivraison());
        model.addAttribute("lieux", lieuService.findAll());
        return "frais_livraison/form";
    }

    @GetMapping("/modifier")
    public String edit(@RequestParam Integer lieuId, @RequestParam String dateFrais, Model model) {
        model.addAttribute("activePage", "fraisLivraison");
        LocalDateTime date = LocalDateTime.parse(dateFrais);
        com.chaussures.models.FraisLivraisonId id = new com.chaussures.models.FraisLivraisonId(lieuId, date);
        model.addAttribute("item", service.findById(id).orElse(new FraisLivraison()));
        model.addAttribute("lieux", lieuService.findAll());
        model.addAttribute("isEdit", true);
        return "frais_livraison/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute FraisLivraison item, @RequestParam Integer idLieu, @RequestParam(required = false) String originalDate) {
        lieuService.findById(idLieu).ifPresent(item::setLieu);
        if (originalDate != null && !originalDate.isEmpty()) {
             item.setDateFrais(LocalDateTime.parse(originalDate));
        } else {
             item.setDateFrais(LocalDateTime.now());
        }
        service.save(item);
        return "redirect:/frais-livraison";
    }
}
