package com.chaussures.services;

import com.chaussures.models.Marque;
import com.chaussures.repositories.MarqueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class MarqueService {
    @Autowired
    private MarqueRepository repository;

    public List<Marque> findAll() { return repository.findAll(); }
    public Optional<Marque> findById(Integer id) { return repository.findById(id); }
    public Marque save(Marque entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
