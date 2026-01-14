package com.chaussures.controllers;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
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

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(BigDecimal.class, new CustomNumberEditor(BigDecimal.class, true));
    }

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
        model.addAttribute("marques", marqueService.findAll());
        model.addAttribute("coupes", coupeService.findAll());
        return "chaussures/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "chaussures");
        model.addAttribute("chaussure", service.findById(id).orElse(new Chaussures()));
        model.addAttribute("marques", marqueService.findAll());
        model.addAttribute("coupes", coupeService.findAll());
        return "chaussures/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute("chaussure") Chaussures chaussure, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("activePage", "chaussures");
            model.addAttribute("marques", marqueService.findAll());
            model.addAttribute("coupes", coupeService.findAll());
            return "chaussures/form";
        }
        service.save(chaussure);
        return "redirect:/chaussures";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/chaussures";
    }
}
