package com.chaussures.services;

import com.chaussures.models.FraisLivraison;
import com.chaussures.repositories.FraisLivraisonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class FraisLivraisonService {

    @Autowired
    private FraisLivraisonRepository repository;

    public List<FraisLivraison> findAll() {
        return repository.findAll();
    }

    public Optional<FraisLivraison> findLatestByLieu(Integer lieuId) {
        return repository.findLatestByLieuId(lieuId);
    }

    public BigDecimal getFraisActuel(Integer lieuId) {
        if (lieuId == null) return BigDecimal.ZERO;
        return repository.findLatestByLieuId(lieuId)
                .map(FraisLivraison::getMontant)
                .orElse(BigDecimal.ZERO);
    }

    public Optional<FraisLivraison> findById(com.chaussures.models.FraisLivraisonId id) {
        return repository.findById(id);
    }

    public FraisLivraison save(FraisLivraison frais) {
        return repository.save(frais);
    }
}
