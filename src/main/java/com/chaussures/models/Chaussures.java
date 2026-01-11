package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "chaussures")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Chaussures {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 255)
    private String nom;

    @ManyToOne
    @JoinColumn(name = "id_coupe")
    private Coupe coupe;

    @ManyToOne
    @JoinColumn(name = "id_marque")
    private Marque marque;

    private BigDecimal prix;
}
