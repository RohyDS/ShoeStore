package com.chaussures.repositories;

import com.chaussures.models.Retour;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.math.BigDecimal;

public interface RetourRepository extends JpaRepository<Retour, Integer> {
    @Query("SELECT SUM(r.montantRembourse) FROM Retour r")
    BigDecimal getTotalRetours();
}
