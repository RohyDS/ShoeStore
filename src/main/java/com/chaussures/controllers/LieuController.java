package com.chaussures.controllers;

import com.chaussures.models.Lieu;
import com.chaussures.services.LieuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/lieu")
public class LieuController {
    @Autowired private LieuService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "lieu");
        model.addAttribute("items", service.findAll());
        return "lieu/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "lieu");
        model.addAttribute("item", new Lieu());
        return "lieu/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "lieu");
        model.addAttribute("item", service.findById(id).orElse(new Lieu()));
        return "lieu/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Lieu item) {
        service.save(item);
        return "redirect:/lieu";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/lieu";
    }
}
