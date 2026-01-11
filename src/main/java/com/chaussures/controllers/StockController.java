package com.chaussures.controllers;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chaussures.models.Stock;
import com.chaussures.services.ChaussuresCouleurPointureService;
import com.chaussures.services.StockService;
import com.chaussures.services.TypeMvtStockService;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @Autowired
    private ChaussuresCouleurPointureService ccpService;

    @Autowired
    private TypeMvtStockService typeMvtService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("activePage", "stock");
        model.addAttribute("stocks", stockService.findAll());
        return "stock/liste";
    }

    @GetMapping("/nouveau")
    public String showForm(Model model) {
        model.addAttribute("activePage", "stock");
        model.addAttribute("stock", new Stock());
        model.addAttribute("variantes", ccpService.findAll());
        model.addAttribute("typesMvt", typeMvtService.findAll());
        return "stock/form";
    }

    @PostMapping("/enregistrer")
    public String save(@ModelAttribute Stock stock) {
        if (stock.getDateMvt() == null) {
            stock.setDateMvt(LocalDateTime.now());
        }
        
        // Si c'est une sortie (ID 2), on s'assure que la quantité est négative
        if (stock.getTypeMvtStock() != null && stock.getTypeMvtStock().getId() == 2) {
            if (stock.getQuantite() > 0) {
                stock.setQuantite(-stock.getQuantite());
            }
        } else {
            // Si c'est une entrée (ID 1), on s'assure que la quantité est positive
            if (stock.getQuantite() < 0) {
                stock.setQuantite(Math.abs(stock.getQuantite()));
            }
        }
        
        stockService.save(stock);
        return "redirect:/stock";
    }
}
