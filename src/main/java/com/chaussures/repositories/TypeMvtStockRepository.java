package com.chaussures.repositories;

import com.chaussures.models.TypeMvtStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeMvtStockRepository extends JpaRepository<TypeMvtStock, Integer> {
}
