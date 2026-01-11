package com.chaussures.controllers;

import com.chaussures.models.Coupe;
import com.chaussures.services.CoupeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/coupe")
public class CoupeController {
    @Autowired private CoupeService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "coupe");
        model.addAttribute("items", service.findAll());
        model.addAttribute("title", "Coupes");
        model.addAttribute("basePath", "coupe");
        return "common/crud_list";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "coupe");
        model.addAttribute("item", new Coupe());
        model.addAttribute("title", "Nouvelle Coupe");
        model.addAttribute("basePath", "coupe");
        return "common/crud_form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "coupe");
        model.addAttribute("item", service.findById(id).orElse(new Coupe()));
        model.addAttribute("title", "Modifier Coupe");
        model.addAttribute("basePath", "coupe");
        return "common/crud_form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Coupe item) {
        service.save(item);
        return "redirect:/coupe";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/coupe";
    }
}
