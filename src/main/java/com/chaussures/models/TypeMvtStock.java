package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "type_mvtstock")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TypeMvtStock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nom;
}
