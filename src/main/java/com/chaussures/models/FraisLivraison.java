package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "frais_livraison")
@IdClass(FraisLivraisonId.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FraisLivraison {
    @Id
    @ManyToOne
    @JoinColumn(name = "id_lieu")
    private Lieu lieu;

    @Id
    @Column(name = "date_frais")
    private LocalDateTime dateFrais;

    @Column(name = "montant", nullable = false)
    private BigDecimal montant;
}
