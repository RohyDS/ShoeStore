package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "couleur")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Couleur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(name = "majoration_pourcentage")
    private Double majorationPourcentage;
}
