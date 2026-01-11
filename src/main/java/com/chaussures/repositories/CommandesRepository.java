package com.chaussures.repositories;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.chaussures.models.Commandes;

@Repository
public interface CommandesRepository extends JpaRepository<Commandes, Integer> {
    long countByDateCommandeAfter(LocalDateTime date);
    List<Commandes> findAllByOrderByDateCommandeDesc(Pageable pageable);
}
