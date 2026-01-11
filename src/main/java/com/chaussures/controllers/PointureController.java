package com.chaussures.controllers;

import com.chaussures.models.Pointure;
import com.chaussures.services.PointureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/pointure")
public class PointureController {
    @Autowired private PointureService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "pointure");
        model.addAttribute("pointures", service.findAll());
        return "pointure/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "pointure");
        model.addAttribute("pointure", new Pointure());
        return "pointure/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "pointure");
        model.addAttribute("pointure", service.findById(id).orElse(new Pointure()));
        return "pointure/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Pointure item) {
        service.save(item);
        return "redirect:/pointure";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/pointure";
    }
}
