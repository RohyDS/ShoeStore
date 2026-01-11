package com.chaussures.models;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "pointure")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Pointure {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 50)
    private String nom;

    @Column(name = "p_eur")
    private BigDecimal eur;

    @Column(name = "p_us")
    private BigDecimal us;

    @Column(name = "p_uk")
    private BigDecimal uk;
}
