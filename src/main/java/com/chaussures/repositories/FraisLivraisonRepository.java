package com.chaussures.repositories;

import com.chaussures.models.FraisLivraison;
import com.chaussures.models.Lieu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.Optional;

public interface FraisLivraisonRepository extends JpaRepository<FraisLivraison, Object> {
    
    @Query("SELECT f FROM FraisLivraison f WHERE f.lieu = :lieu ORDER BY f.dateFrais DESC LIMIT 1")
    Optional<FraisLivraison> findLatestByLieu(@Param("lieu") Lieu lieu);
}
