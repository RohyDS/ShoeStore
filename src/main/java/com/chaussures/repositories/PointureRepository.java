package com.chaussures.repositories;

import com.chaussures.models.Pointure;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PointureRepository extends JpaRepository<Pointure, Integer> {
}
