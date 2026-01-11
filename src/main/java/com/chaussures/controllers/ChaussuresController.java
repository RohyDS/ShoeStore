package com.chaussures.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chaussures.models.Chaussures;
import com.chaussures.services.ChaussuresService;
import com.chaussures.services.CoupeService;
import com.chaussures.services.MarqueService;

@Controller
@RequestMapping("/chaussures")
public class ChaussuresController {

    @Autowired
    private ChaussuresService service;

    @Autowired
    private CoupeService coupeService;

    @Autowired
    private MarqueService marqueService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "chaussures");
        model.addAttribute("chaussures", service.findAll());
        return "chaussures/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "chaussures");
        model.addAttribute("chaussure", new Chaussures());
        model.addAttribute("coupes", coupeService.findAll());
        model.addAttribute("marques", marqueService.findAll());
        return "chaussures/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "chaussures");
        model.addAttribute("chaussure", service.findById(id).orElse(new Chaussures()));
        model.addAttribute("coupes", coupeService.findAll());
        model.addAttribute("marques", marqueService.findAll());
        return "chaussures/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Chaussures chaussure) {
        service.save(chaussure);
        return "redirect:/chaussures";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/chaussures";
    }
}
