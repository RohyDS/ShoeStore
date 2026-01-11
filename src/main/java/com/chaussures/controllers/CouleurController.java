package com.chaussures.controllers;

import com.chaussures.models.Couleur;
import com.chaussures.services.CouleurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/couleur")
public class CouleurController {
    @Autowired private CouleurService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "couleur");
        model.addAttribute("items", service.findAll());
        model.addAttribute("title", "Couleurs");
        model.addAttribute("basePath", "couleur");
        return "common/crud_list";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "couleur");
        model.addAttribute("item", new Couleur());
        model.addAttribute("title", "Nouvelle Couleur");
        model.addAttribute("basePath", "couleur");
        return "common/crud_form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "couleur");
        model.addAttribute("item", service.findById(id).orElse(new Couleur()));
        model.addAttribute("title", "Modifier Couleur");
        model.addAttribute("basePath", "couleur");
        return "common/crud_form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Couleur item) {
        service.save(item);
        return "redirect:/couleur";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/couleur";
    }
}
