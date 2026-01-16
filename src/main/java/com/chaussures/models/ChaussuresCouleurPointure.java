package com.chaussures.models;

import java.math.BigDecimal;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "chaussures_couleur_pointure")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChaussuresCouleurPointure {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_chaussure_genre")
    private ChaussuresGenres chaussureGenre;

    @ManyToOne
    @JoinColumn(name = "id_couleur")
    private Couleur couleur;

    @ManyToOne
    @JoinColumn(name = "id_pointure")
    private Pointure pointure;

    private BigDecimal prix;

    public BigDecimal getPrixEffectif() {
        BigDecimal basePrix = BigDecimal.ZERO;
        if (prix != null) {
            basePrix = prix;
        } else if (chaussureGenre != null) {
            basePrix = chaussureGenre.getPrixEffectif();
        }

        // Appliquer la majoration par couleur si elle existe
        if (couleur != null && couleur.getMajorationPourcentage() != null && couleur.getMajorationPourcentage() > 0) {
            BigDecimal majoration = basePrix.multiply(new BigDecimal(couleur.getMajorationPourcentage() / 100.0));
            return basePrix.add(majoration);
        }

        return basePrix;
    }
}
