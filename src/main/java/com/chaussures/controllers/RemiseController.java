package com.chaussures.controllers;

import com.chaussures.models.Remise;
import com.chaussures.services.RemiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/remise")
public class RemiseController {
    @Autowired private RemiseService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "remise");
        model.addAttribute("remises", service.findAll());
        return "remise/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "remise");
        model.addAttribute("remise", new Remise());
        return "remise/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "remise");
        model.addAttribute("remise", service.findById(id).orElse(new Remise()));
        return "remise/form";
    }

    @PostMapping("/enregistrer")
    public String save(@RequestParam(required = false) Integer id, 
                       @RequestParam Integer quantite, 
                       @RequestParam Double remise) {
        Remise r = new Remise();
        if (id != null) r.setId(id);
        r.setQuantite(quantite);
        r.setRemise(remise);
        service.save(r);
        return "redirect:/remise";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/remise";
    }
}
