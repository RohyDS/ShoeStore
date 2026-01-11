package com.chaussures.services;

import com.chaussures.models.Commandes;
import com.chaussures.repositories.CommandesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommandesService {

    @Autowired
    private CommandesRepository repository;

    public List<Commandes> findAll() {
        return repository.findAll();
    }

    public Optional<Commandes> findById(Integer id) {
        return repository.findById(id);
    }

    public Commandes save(Commandes commandes) {
        return repository.save(commandes);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
