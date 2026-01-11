package com.chaussures.services;

import com.chaussures.models.Pointure;
import com.chaussures.repositories.PointureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PointureService {
    @Autowired
    private PointureRepository repository;

    public List<Pointure> findAll() { return repository.findAll(); }
    public Optional<Pointure> findById(Integer id) { return repository.findById(id); }
    public Pointure save(Pointure entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
