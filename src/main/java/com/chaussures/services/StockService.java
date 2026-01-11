package com.chaussures.services;

import com.chaussures.models.Stock;
import com.chaussures.repositories.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StockService {

    @Autowired
    private StockRepository repository;

    public List<Stock> findAll() {
        return repository.findAll();
    }

    public Optional<Stock> findById(Integer id) {
        return repository.findById(id);
    }

    public Stock save(Stock stock) {
        return repository.save(stock);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
