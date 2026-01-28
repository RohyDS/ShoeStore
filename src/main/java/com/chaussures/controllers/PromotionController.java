package com.chaussures.controllers;

import com.chaussures.models.EvenementsPromos;
import com.chaussures.services.EvenementsPromosService;
import com.chaussures.services.ChaussuresGenresService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/admin/promotions")
public class PromotionController {

    @Autowired
    private EvenementsPromosService evenementsPromosService;

    @Autowired
    private ChaussuresGenresService chaussuresGenresService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("promotions", evenementsPromosService.findAll());
        model.addAttribute("chaussureGenres", chaussuresGenresService.findAll());
        return "admin/promotions";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute EvenementsPromos promo, 
                       @RequestParam("dateDebutStr") String dateDebutStr,
                       @RequestParam("dateFinStr") String dateFinStr) {
        // Conversion manuelle des dates HTML5 (yyyy-MM-ddTHH:mm) vers LocalDateTime
        promo.setDateDebut(LocalDateTime.parse(dateDebutStr));
        promo.setDateFin(LocalDateTime.parse(dateFinStr));
        evenementsPromosService.save(promo);
        return "redirect:/admin/promotions";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        evenementsPromosService.deleteById(id);
        return "redirect:/admin/promotions";
    }
}
