package com.chaussures.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chaussures.models.ChaussuresCouleurPointure;
import com.chaussures.models.PrixChaussuresDetails;
import com.chaussures.repositories.ChaussuresCouleurPointureRepository;
import com.chaussures.repositories.PrixChaussuresDetailsRepository;

@Service
public class ChaussuresCouleurPointureService {
    @Autowired
    private ChaussuresCouleurPointureRepository repository;

    @Autowired
    private PrixChaussuresDetailsRepository prixDetailsRepository;

    public List<ChaussuresCouleurPointure> findAll() {
        return repository.findAll();
    }

    public Page<ChaussuresCouleurPointure> findWithFilters(String nom, Integer catId, Integer genreId, Integer couleurId, Integer pointureId, Pageable pageable) {
        String nomPattern = (nom != null && !nom.isEmpty()) ? "%" + nom + "%" : null;
        return repository.findWithFilters(nomPattern, catId, genreId, couleurId, pointureId, pageable);
    }

    public Optional<ChaussuresCouleurPointure> findById(Integer id) {
        return repository.findById(id);
    }

    @Transactional
    public ChaussuresCouleurPointure save(ChaussuresCouleurPointure entity) {
        // On sauvegarde d'abord la variante pour avoir son ID si c'est une création
        ChaussuresCouleurPointure saved = repository.save(entity);
        
        // On enregistre l'historique du prix spécifique
        if (saved.getPrix() != null) {
            PrixChaussuresDetails prixHist = new PrixChaussuresDetails();
            prixHist.setChaussuresCouleurPointure(saved);
            prixHist.setPrix(saved.getPrix());
            
            PrixChaussuresDetails.PrixChaussuresDetailsId id = new PrixChaussuresDetails.PrixChaussuresDetailsId();
            id.setIdChaussuresCouleurPointure(saved.getId());
            id.setDatePrix(LocalDateTime.now());
            prixHist.setId(id);
            
            prixDetailsRepository.save(prixHist);
        }
        
        return saved;
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
