package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "stock")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Stock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_chaussures_couleur_pointure")
    private ChaussuresCouleurPointure chaussuresCouleurPointure;

    @ManyToOne
    @JoinColumn(name = "id_type_mvtstock")
    private TypeMvtStock typeMvtStock;

    @Column(nullable = false)
    private Integer quantite;

    @Column(name = "date_mvt")
    private LocalDateTime dateMvt;
}
