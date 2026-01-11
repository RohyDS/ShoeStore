package com.chaussures.repositories;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.chaussures.models.CommandesDetails;

@Repository
public interface CommandesDetailsRepository extends JpaRepository<CommandesDetails, Integer> {
    @Query("SELECT COALESCE(SUM(cd.prix * cd.quantite), 0) FROM CommandesDetails cd")
    BigDecimal sumTotalRevenue();

    @Query("SELECT cd FROM CommandesDetails cd " +
           "JOIN FETCH cd.chaussuresCouleurPointure ccp " +
           "JOIN FETCH ccp.chaussureGenre cg " +
           "JOIN FETCH cg.chaussure " +
           "JOIN FETCH cg.categories " +
           "JOIN FETCH cg.genre " +
           "JOIN FETCH ccp.couleur " +
           "JOIN FETCH ccp.pointure " +
           "WHERE cd.commande.id = :commandeId")
    java.util.List<CommandesDetails> findByCommandeId(@Param("commandeId") Integer commandeId);
}
