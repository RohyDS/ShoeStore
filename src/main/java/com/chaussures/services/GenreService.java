package com.chaussures.services;

import com.chaussures.models.Genre;
import com.chaussures.repositories.GenreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class GenreService {
    @Autowired
    private GenreRepository repository;

    public List<Genre> findAll() { return repository.findAll(); }
    public Optional<Genre> findById(Integer id) { return repository.findById(id); }
    public Genre save(Genre entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
