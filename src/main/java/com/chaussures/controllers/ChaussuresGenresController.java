package com.chaussures.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chaussures.models.ChaussuresGenres;
import com.chaussures.services.CategoriesService;
import com.chaussures.services.ChaussuresGenresService;
import com.chaussures.services.ChaussuresService;
import com.chaussures.services.GenreService;

@Controller
@RequestMapping("/chaussures-genres")
public class ChaussuresGenresController {

    @Autowired
    private ChaussuresGenresService service;

    @Autowired
    private ChaussuresService chaussuresService;

    @Autowired
    private GenreService genreService;

    @Autowired
    private CategoriesService categoriesService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "chaussuresGenres");
        model.addAttribute("items", service.findAll());
        return "chaussures_genres/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "chaussuresGenres");
        model.addAttribute("item", new ChaussuresGenres());
        model.addAttribute("chaussures", chaussuresService.findAll());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("categories", categoriesService.findAll());
        return "chaussures_genres/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "chaussuresGenres");
        model.addAttribute("item", service.findById(id).orElse(new ChaussuresGenres()));
        model.addAttribute("chaussures", chaussuresService.findAll());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("categories", categoriesService.findAll());
        return "chaussures_genres/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute ChaussuresGenres item) {
        service.save(item);
        return "redirect:/chaussures-genres";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/chaussures-genres";
    }
}
