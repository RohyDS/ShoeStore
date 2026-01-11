package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "commandes_details")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommandesDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cd")
    private Integer idCd;

    @ManyToOne
    @JoinColumn(name = "id_commande")
    private Commandes commande;

    @ManyToOne
    @JoinColumn(name = "id_chaussures_couleur_pointure")
    private ChaussuresCouleurPointure chaussuresCouleurPointure;

    @Column(nullable = false)
    private Integer quantite;

    @Column(nullable = false)
    private BigDecimal prix;
}
