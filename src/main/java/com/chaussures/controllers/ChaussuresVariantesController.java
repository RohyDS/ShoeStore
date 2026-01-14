package com.chaussures.controllers;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.chaussures.models.ChaussuresCouleurPointure;
import com.chaussures.services.CategoriesService;
import com.chaussures.services.ChaussuresCouleurPointureService;
import com.chaussures.services.ChaussuresGenresService;
import com.chaussures.services.CouleurService;
import com.chaussures.services.GenreService;
import com.chaussures.services.PointureService;

@Controller
@RequestMapping("/chaussures-variantes")
public class ChaussuresVariantesController {

    @Autowired
    private ChaussuresCouleurPointureService service;

    @Autowired
    private ChaussuresGenresService chaussuresGenresService;

    @Autowired
    private CouleurService couleurService;

    @Autowired
    private PointureService pointureService;

    @Autowired
    private CategoriesService categoriesService;

    @Autowired
    private GenreService genreService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(BigDecimal.class, new CustomNumberEditor(BigDecimal.class, true));
    }

    @GetMapping
    public String list(
            @RequestParam(required = false) String nom,
            @RequestParam(required = false) Integer categorieId,
            @RequestParam(required = false) Integer genreId,
            @RequestParam(required = false) Integer couleurId,
            @RequestParam(required = false) Integer pointureId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        Page<ChaussuresCouleurPointure> variantesPage = service.findWithFilters(
                nom, categorieId, genreId, couleurId, pointureId, PageRequest.of(page, size));

        model.addAttribute("activePage", "variantes");
        model.addAttribute("variantes", variantesPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", variantesPage.getTotalPages());
        model.addAttribute("totalItems", variantesPage.getTotalElements());
        
        // Filtres pour la vue
        model.addAttribute("categories", categoriesService.findAll());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("couleurs", couleurService.findAll());
        model.addAttribute("pointures", pointureService.findAll());
        
        // Valeurs actuelles des filtres
        model.addAttribute("nom", nom);
        model.addAttribute("categorieId", categorieId);
        model.addAttribute("genreId", genreId);
        model.addAttribute("couleurId", couleurId);
        model.addAttribute("pointureId", pointureId);
        
        return "chaussures_variantes/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "variantes");
        model.addAttribute("variante", new ChaussuresCouleurPointure());
        model.addAttribute("chaussuresGenres", chaussuresGenresService.findAll());
        model.addAttribute("couleurs", couleurService.findAll());
        model.addAttribute("pointures", pointureService.findAll());
        return "chaussures_variantes/form";
    }

    @GetMapping("/modifier/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "variantes");
        model.addAttribute("variante", service.findById(id).orElse(new ChaussuresCouleurPointure()));
        model.addAttribute("chaussuresGenres", chaussuresGenresService.findAll());
        model.addAttribute("couleurs", couleurService.findAll());
        model.addAttribute("pointures", pointureService.findAll());
        return "chaussures_variantes/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute("variante") ChaussuresCouleurPointure variante, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("activePage", "variantes");
            model.addAttribute("chaussuresGenres", chaussuresGenresService.findAll());
            model.addAttribute("couleurs", couleurService.findAll());
            model.addAttribute("pointures", pointureService.findAll());
            return "chaussures_variantes/form";
        }
        service.save(variante);
        return "redirect:/chaussures-variantes";
    }

    @GetMapping("/supprimer/{id}")
    public String delete(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/chaussures-variantes";
    }
}
