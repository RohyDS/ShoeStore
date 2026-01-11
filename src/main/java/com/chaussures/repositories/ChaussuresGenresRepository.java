package com.chaussures.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.chaussures.models.ChaussuresGenres;

@Repository
public interface ChaussuresGenresRepository extends JpaRepository<ChaussuresGenres, Integer> {
}
