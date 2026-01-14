package com.chaussures.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chaussures.models.ChaussuresGenres;
import com.chaussures.models.PrixChaussuresGenresDetails;
import com.chaussures.repositories.ChaussuresGenresRepository;
import com.chaussures.repositories.PrixChaussuresGenresDetailsRepository;

@Service
public class ChaussuresGenresService {

    @Autowired
    private ChaussuresGenresRepository repository;

    @Autowired
    private PrixChaussuresGenresDetailsRepository prixRepository;

    public List<ChaussuresGenres> findAll() {
        return repository.findAll();
    }

    public Optional<ChaussuresGenres> findById(Integer id) {
        return repository.findById(id);
    }

    @Transactional
    public ChaussuresGenres save(ChaussuresGenres entity) {
        ChaussuresGenres saved = repository.save(entity);

        // On enregistre l'historique du prix
        if (saved.getPrix() != null) {
            PrixChaussuresGenresDetails prixHist = new PrixChaussuresGenresDetails();
            prixHist.setChaussuresGenres(saved);
            prixHist.setPrix(saved.getPrix());

            PrixChaussuresGenresDetails.PrixChaussuresGenresDetailsId id = new PrixChaussuresGenresDetails.PrixChaussuresGenresDetailsId();
            id.setIdChaussureGenre(saved.getId());
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
