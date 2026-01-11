package com.chaussures.services;

import com.chaussures.models.ChaussuresGenres;
import com.chaussures.repositories.ChaussuresGenresRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ChaussuresGenresService {

    @Autowired
    private ChaussuresGenresRepository repository;

    public List<ChaussuresGenres> findAll() {
        return repository.findAll();
    }

    public Optional<ChaussuresGenres> findById(Integer id) {
        return repository.findById(id);
    }

    public ChaussuresGenres save(ChaussuresGenres entity) {
        return repository.save(entity);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
