package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "lieu")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Lieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String nom;
}
