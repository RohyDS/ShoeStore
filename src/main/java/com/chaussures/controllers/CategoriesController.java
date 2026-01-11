package com.chaussures.controllers;

import com.chaussures.models.Categories;
import com.chaussures.services.CategoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/categories")
public class CategoriesController {
    @Autowired private CategoriesService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "categories");
        model.addAttribute("items", service.findAll());
        model.addAttribute("title", "Catégories");
        model.addAttribute("basePath", "categories");
        return "common/crud_list";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "categories");
        model.addAttribute("item", new Categories());
        model.addAttribute("title", "Nouvelle Catégorie");
        model.addAttribute("basePath", "categories");
        return "common/crud_form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "categories");
        model.addAttribute("item", service.findById(id).orElse(new Categories()));
        model.addAttribute("title", "Modifier Catégorie");
        model.addAttribute("basePath", "categories");
        return "common/crud_form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Categories item) {
        service.save(item);
        return "redirect:/categories";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/categories";
    }
}
