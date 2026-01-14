package com.chaussures.repositories;

import com.chaussures.models.Remise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface RemiseRepository extends JpaRepository<Remise, Integer> {
    @Query("SELECT r FROM Remise r WHERE r.quantite < :q ORDER BY r.quantite DESC LIMIT 1")
    Optional<Remise> findApplicableRemise(@Param("q") Integer quantite);
}
