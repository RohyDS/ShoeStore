package com.chaussures.services;

import com.chaussures.models.Coupe;
import com.chaussures.repositories.CoupeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CoupeService {
    @Autowired
    private CoupeRepository repository;

    public List<Coupe> findAll() { return repository.findAll(); }
    public Optional<Coupe> findById(Integer id) { return repository.findById(id); }
    public Coupe save(Coupe entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
