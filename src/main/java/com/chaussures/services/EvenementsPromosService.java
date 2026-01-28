package com.chaussures.services;

import com.chaussures.models.EvenementsPromos;
import com.chaussures.repositories.EvenementsPromosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EvenementsPromosService {
    
    @Autowired
    private EvenementsPromosRepository evenementsPromosRepository;

    public List<EvenementsPromos> getActivePromos(LocalDateTime now) {
        return evenementsPromosRepository.findActivePromos(now);
    }

    public List<EvenementsPromos> getActivePromos() {
        return getActivePromos(LocalDateTime.now());
    }

    public List<EvenementsPromos> findAll() {
        return evenementsPromosRepository.findAll();
    }

    public EvenementsPromos save(EvenementsPromos promo) {
        return evenementsPromosRepository.save(promo);
    }

    public void deleteById(Integer id) {
        evenementsPromosRepository.deleteById(id);
    }

    public EvenementsPromos findById(Integer id) {
        return evenementsPromosRepository.findById(id).orElse(null);
    }
}
