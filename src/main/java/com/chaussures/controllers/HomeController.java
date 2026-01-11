package com.chaussures.controllers;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.chaussures.repositories.ClientsRepository;
import com.chaussures.repositories.CommandesDetailsRepository;
import com.chaussures.repositories.CommandesRepository;
import com.chaussures.repositories.StockRepository;

@Controller
public class HomeController {

    @Autowired
    private CommandesRepository commandesRepository;

    @Autowired
    private ClientsRepository clientsRepository;

    @Autowired
    private CommandesDetailsRepository commandesDetailsRepository;

    @Autowired
    private StockRepository stockRepository;

    @GetMapping("/")
    public String index(Model model) {
        LocalDateTime todayStart = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        
        model.addAttribute("activePage", "home");
        model.addAttribute("commandesToday", commandesRepository.countByDateCommandeAfter(todayStart));
        model.addAttribute("totalClients", clientsRepository.count());
        model.addAttribute("totalRevenue", commandesDetailsRepository.sumTotalRevenue());
        model.addAttribute("lowStockCount", stockRepository.countLowStockItems());
        model.addAttribute("recentCommandes", commandesRepository.findAllByOrderByDateCommandeDesc(PageRequest.of(0, 5)));
        
        return "index";
    }
}
