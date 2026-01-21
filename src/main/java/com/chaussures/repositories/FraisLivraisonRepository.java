package com.chaussures.repositories;

import com.chaussures.models.FraisLivraison;
import com.chaussures.models.Lieu;
import com.chaussures.models.FraisLivraisonId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.Optional;

public interface FraisLivraisonRepository extends JpaRepository<FraisLivraison, FraisLivraisonId> {
    
    @Query("SELECT f FROM FraisLivraison f WHERE f.lieu.id = :lieuId ORDER BY f.dateFrais DESC LIMIT 1")
    Optional<FraisLivraison> findLatestByLieuId(@Param("lieuId") Integer lieuId);
}
