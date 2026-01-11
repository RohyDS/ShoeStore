package com.chaussures.services;

import com.chaussures.models.CommandesDetails;
import com.chaussures.repositories.CommandesDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommandesDetailsService {

    @Autowired
    private CommandesDetailsRepository repository;

    public List<CommandesDetails> findAll() {
        return repository.findAll();
    }

    public Optional<CommandesDetails> findById(Integer id) {
        return repository.findById(id);
    }

    public CommandesDetails save(CommandesDetails details) {
        return repository.save(details);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }

    public List<CommandesDetails> findByCommandeId(Integer commandeId) {
        return repository.findByCommandeId(commandeId);
    }
}
