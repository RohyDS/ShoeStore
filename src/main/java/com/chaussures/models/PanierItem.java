package com.chaussures.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PanierItem {
    private Integer varianteId;
    private String nom;
    private String categorie;
    private String genre;
    private String couleur;
    private String pointure;
    private Integer quantite;
    private BigDecimal prixUnitaire;
    private Double remisePourcentage; // Remise effective (la meilleure entre ligne et globale)
    private BigDecimal prixRemise;    // Prix après remise effective
    private Double remiseLignePourcentage; // Remise basée uniquement sur la quantité de cet article

    public BigDecimal getTotal() {
        return (prixRemise != null ? prixRemise : prixUnitaire).multiply(new BigDecimal(quantite));
    }

    public BigDecimal getPrixLigneRemise() {
        if (remiseLignePourcentage == null) return prixUnitaire;
        BigDecimal reduction = prixUnitaire.multiply(new BigDecimal(remiseLignePourcentage / 100.0));
        return prixUnitaire.subtract(reduction);
    }

    public BigDecimal getEconomie() {
        if (prixRemise == null) return BigDecimal.ZERO;
        return prixUnitaire.subtract(prixRemise).multiply(new BigDecimal(quantite));
    }
}
