package com.chaussures.services;

import com.chaussures.models.Clients;
import com.chaussures.repositories.ClientsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClientsService {

    @Autowired
    private ClientsRepository repository;

    public List<Clients> findAll() {
        return repository.findAll();
    }

    public Optional<Clients> findById(Integer id) {
        return repository.findById(id);
    }

    public Clients save(Clients clients) {
        return repository.save(clients);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
