package com.chaussures.repositories;

import com.chaussures.models.PrixChaussuresDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrixChaussuresDetailsRepository extends JpaRepository<PrixChaussuresDetails, PrixChaussuresDetails.PrixChaussuresDetailsId> {
}
