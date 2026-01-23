package com.chaussures.models;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "retours")
@Data
public class Retour {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_cd")
    private CommandesDetails commandeDetail;

    @Column(nullable = false)
    private Integer quantite;

    @Column(name = "montant_rembourse", nullable = false)
    private BigDecimal montantRembourse;

    @Column(columnDefinition = "TEXT")
    private String motif;

    @Column(name = "date_retour")
    private LocalDateTime dateRetour = LocalDateTime.now();
}
