package com.chaussures.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.chaussures.models.Stock;

@Repository
public interface StockRepository extends JpaRepository<Stock, Integer> {
    @Query("SELECT COUNT(v) FROM ChaussuresCouleurPointure v WHERE " +
           "(SELECT COALESCE(SUM(CASE WHEN s.typeMvtStock.id = 1 THEN s.quantite ELSE -s.quantite END), 0) " +
           "FROM Stock s WHERE s.chaussuresCouleurPointure = v) < 5")
    long countLowStockItems();

    @Query("SELECT COALESCE(SUM(CASE WHEN s.typeMvtStock.id = 1 THEN s.quantite ELSE -s.quantite END), 0) " +
           "FROM Stock s WHERE s.chaussuresCouleurPointure.id = :varianteId")
    Integer getStockByVarianteId(Integer varianteId);
}
