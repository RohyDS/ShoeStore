package com.chaussures.services;

import com.chaussures.models.Couleur;
import com.chaussures.repositories.CouleurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CouleurService {
    @Autowired
    private CouleurRepository repository;

    public List<Couleur> findAll() { return repository.findAll(); }
    public Optional<Couleur> findById(Integer id) { return repository.findById(id); }
    public Couleur save(Couleur entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
