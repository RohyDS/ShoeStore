package com.chaussures.repositories;

import com.chaussures.models.Lieu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LieuRepository extends JpaRepository<Lieu, Integer> {
}
