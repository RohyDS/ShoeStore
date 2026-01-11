package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "coupe")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Coupe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nom;
}
