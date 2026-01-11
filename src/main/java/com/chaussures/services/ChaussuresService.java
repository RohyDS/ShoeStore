package com.chaussures.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chaussures.models.Chaussures;
import com.chaussures.models.PrixChaussures;
import com.chaussures.repositories.ChaussuresRepository;
import com.chaussures.repositories.PrixChaussuresRepository;

@Service
public class ChaussuresService {

    @Autowired
    private ChaussuresRepository repository;

    @Autowired
    private PrixChaussuresRepository prixRepository;

    public List<Chaussures> findAll() {
        return repository.findAll();
    }

    public Optional<Chaussures> findById(Integer id) {
        return repository.findById(id);
    }

    @Transactional
    public Chaussures save(Chaussures chaussures) {
        // On sauvegarde d'abord la chaussure pour avoir son ID si c'est une création
        Chaussures saved = repository.save(chaussures);
        
        // On enregistre l'historique du prix
        if (saved.getPrix() != null) {
            PrixChaussures prixHist = new PrixChaussures();
            prixHist.setChaussure(saved);
            prixHist.setPrix(saved.getPrix());
            
            PrixChaussures.PrixChaussuresId id = new PrixChaussures.PrixChaussuresId();
            id.setIdChaussures(saved.getId());
            id.setDatePrix(LocalDateTime.now());
            prixHist.setId(id);
            
            prixRepository.save(prixHist);
        }
        
        return saved;
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
