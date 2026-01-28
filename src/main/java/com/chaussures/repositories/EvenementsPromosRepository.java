package com.chaussures.repositories;

import com.chaussures.models.EvenementsPromos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDateTime;
import java.util.List;

public interface EvenementsPromosRepository extends JpaRepository<EvenementsPromos, Integer> {
    
    @Query("SELECT e FROM EvenementsPromos e WHERE :now BETWEEN e.dateDebut AND e.dateFin")
    List<EvenementsPromos> findActivePromos(@Param("now") LocalDateTime now);
}
