package com.chaussures.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chaussures.models.Commandes;
import com.chaussures.services.CommandesDetailsService;
import com.chaussures.services.CommandesService;

@Controller
@RequestMapping("/commandes")
public class CommandesController {

    @Autowired
    private CommandesService service;

    @Autowired
    private CommandesDetailsService detailsService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "commandes");
        model.addAttribute("commandes", service.findAll());
        return "commandes/liste";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "commandes");
        model.addAttribute("commande", service.findById(id).orElse(null));
        model.addAttribute("details", detailsService.findByCommandeId(id));
        return "commandes/details";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "commandes");
        model.addAttribute("commande", new Commandes());
        return "commandes/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Commandes commande) {
        service.save(commande);
        return "redirect:/commandes";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/commandes";
    }
}
