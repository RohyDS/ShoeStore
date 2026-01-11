package com.chaussures.services;

import com.chaussures.models.Categories;
import com.chaussures.repositories.CategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CategoriesService {
    @Autowired
    private CategoriesRepository repository;

    public List<Categories> findAll() { return repository.findAll(); }
    public Optional<Categories> findById(Integer id) { return repository.findById(id); }
    public Categories save(Categories entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
