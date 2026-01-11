package com.chaussures.repositories;

import com.chaussures.models.Chaussures;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChaussuresRepository extends JpaRepository<Chaussures, Integer> {
}
