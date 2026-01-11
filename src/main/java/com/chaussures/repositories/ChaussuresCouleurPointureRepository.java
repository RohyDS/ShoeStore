package com.chaussures.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.chaussures.models.ChaussuresCouleurPointure;

@Repository
public interface ChaussuresCouleurPointureRepository extends JpaRepository<ChaussuresCouleurPointure, Integer> {
    
    @Query("SELECT v FROM ChaussuresCouleurPointure v " +
           "JOIN v.chaussureGenre cg " +
           "JOIN cg.chaussure c " +
           "JOIN v.couleur cl " +
           "JOIN v.pointure p " +
           "JOIN cg.genre g " +
           "WHERE (CAST(:nom AS string) IS NULL OR LOWER(c.nom) LIKE LOWER(CAST(:nom AS string))) " +
           "AND (:categorieId IS NULL OR cg.categories.id = :categorieId) " +
           "AND (:genreId IS NULL " +
           "     OR (:genreId = -1 " +
           "         AND EXISTS (SELECT cg1 FROM ChaussuresGenres cg1 WHERE cg1.chaussure.id = c.id AND cg1.genre.nom = 'Masculin') " +
           "         AND EXISTS (SELECT cg2 FROM ChaussuresGenres cg2 WHERE cg2.chaussure.id = c.id AND cg2.genre.nom = 'Feminin')) " +
           "     OR g.id = :genreId) " +
           "AND (:couleurId IS NULL OR cl.id = :couleurId) " +
           "AND (:pointureId IS NULL OR p.id = :pointureId)")
    Page<ChaussuresCouleurPointure> findWithFilters(
            @Param("nom") String nom,
            @Param("categorieId") Integer categorieId,
            @Param("genreId") Integer genreId,
            @Param("couleurId") Integer couleurId,
            @Param("pointureId") Integer pointureId,
            Pageable pageable);
}
