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
    private BigDecimal prix;

    public BigDecimal getTotal() {
        return prix.multiply(new BigDecimal(quantite));
    }
}
