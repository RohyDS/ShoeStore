package com.chaussures.repositories;

import com.chaussures.models.PrixChaussures;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrixChaussuresRepository extends JpaRepository<PrixChaussures, PrixChaussures.PrixChaussuresId> {
}
