package com.chaussures.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chaussures.models.Clients;
import com.chaussures.services.ClientsService;

@Controller
@RequestMapping("/clients")
public class ClientsController {

    @Autowired
    private ClientsService service;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "clients");
        model.addAttribute("clients", service.findAll());
        return "clients/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "clients");
        model.addAttribute("client", new Clients());
        return "clients/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "clients");
        model.addAttribute("client", service.findById(id).orElse(new Clients()));
        return "clients/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Clients client) {
        service.save(client);
        return "redirect:/clients";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/clients";
    }
}
