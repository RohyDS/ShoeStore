package com.chaussures.services;

import com.chaussures.models.Lieu;
import com.chaussures.repositories.LieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LieuService {

    @Autowired
    private LieuRepository lieuRepository;

    public List<Lieu> findAll() {
        return lieuRepository.findAll();
    }

    public Optional<Lieu> findById(Integer id) {
        return lieuRepository.findById(id);
    }

    public Lieu save(Lieu lieu) {
        return lieuRepository.save(lieu);
    }

    public void deleteById(Integer id) {
        lieuRepository.deleteById(id);
    }
}
