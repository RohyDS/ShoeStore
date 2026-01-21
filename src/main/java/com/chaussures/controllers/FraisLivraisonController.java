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

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute FraisLivraison item, @RequestParam Integer idLieu) {
        lieuService.findById(idLieu).ifPresent(item::setLieu);
        item.setDateFrais(LocalDateTime.now());
        service.save(item);
        return "redirect:/frais-livraison";
    }
}
