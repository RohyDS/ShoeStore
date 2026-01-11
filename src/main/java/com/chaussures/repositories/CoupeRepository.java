package com.chaussures.repositories;

import com.chaussures.models.Coupe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CoupeRepository extends JpaRepository<Coupe, Integer> {
}
