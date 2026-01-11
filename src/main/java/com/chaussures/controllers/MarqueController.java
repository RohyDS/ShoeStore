package com.chaussures.controllers;

import com.chaussures.models.Marque;
import com.chaussures.services.MarqueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/marque")
public class MarqueController {
    @Autowired private MarqueService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "marque");
        model.addAttribute("items", service.findAll());
        model.addAttribute("title", "Marques");
        model.addAttribute("basePath", "marque");
        return "common/crud_list";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "marque");
        model.addAttribute("item", new Marque());
        model.addAttribute("title", "Nouvelle Marque");
        model.addAttribute("basePath", "marque");
        return "common/crud_form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "marque");
        model.addAttribute("item", service.findById(id).orElse(new Marque()));
        model.addAttribute("title", "Modifier Marque");
        model.addAttribute("basePath", "marque");
        return "common/crud_form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Marque item) {
        service.save(item);
        return "redirect:/marque";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/marque";
    }
}
