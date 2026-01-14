package com.chaussures.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.chaussures.models.PrixChaussuresGenresDetails;
import com.chaussures.models.PrixChaussuresGenresDetails.PrixChaussuresGenresDetailsId;

@Repository
public interface PrixChaussuresGenresDetailsRepository extends JpaRepository<PrixChaussuresGenresDetails, PrixChaussuresGenresDetailsId> {
}
