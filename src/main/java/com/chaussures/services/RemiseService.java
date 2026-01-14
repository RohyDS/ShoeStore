package com.chaussures.services;

import com.chaussures.models.Remise;
import com.chaussures.repositories.RemiseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class RemiseService {
    @Autowired
    private RemiseRepository repository;

    public List<Remise> findAll() { return repository.findAll(); }
    public Optional<Remise> findById(Integer id) { return repository.findById(id); }
    public Remise save(Remise entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }

    public Optional<Remise> findApplicableRemise(Integer quantite) {
        return repository.findApplicableRemise(quantite);
    }
}
