package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "remise")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Remise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private Integer quantite;

    @Column(nullable = false)
    private Double remise;

    @Column(name = "date_remise", insertable = false, updatable = false)
    private LocalDateTime dateRemise;
}
