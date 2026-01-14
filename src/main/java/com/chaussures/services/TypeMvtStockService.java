package com.chaussures.services;

import com.chaussures.models.TypeMvtStock;
import com.chaussures.repositories.TypeMvtStockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TypeMvtStockService {
    @Autowired
    private TypeMvtStockRepository repository;

    public List<TypeMvtStock> findAll() {
        return repository.findAll();
    }

    public Optional<TypeMvtStock> findById(Integer id) {
        return repository.findById(id);
    }
}
