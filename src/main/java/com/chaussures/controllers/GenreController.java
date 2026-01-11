package com.chaussures.controllers;

import com.chaussures.models.Genre;
import com.chaussures.services.GenreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/genre")
public class GenreController {
    @Autowired private GenreService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "genre");
        model.addAttribute("items", service.findAll());
        model.addAttribute("title", "Genres");
        model.addAttribute("basePath", "genre");
        return "common/crud_list";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "genre");
        model.addAttribute("item", new Genre());
        model.addAttribute("title", "Nouveau Genre");
        model.addAttribute("basePath", "genre");
        return "common/crud_form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "genre");
        model.addAttribute("item", service.findById(id).orElse(new Genre()));
        model.addAttribute("title", "Modifier Genre");
        model.addAttribute("basePath", "genre");
        return "common/crud_form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Genre item) {
        service.save(item);
        return "redirect:/genre";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/genre";
    }
}
