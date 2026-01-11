package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "prix_chaussuresdetails")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PrixChaussuresDetails {

    @EmbeddedId
    private PrixChaussuresDetailsId id;

    @ManyToOne
    @MapsId("idChaussuresCouleurPointure")
    @JoinColumn(name = "id_chaussures_couleur_pointure")
    private ChaussuresCouleurPointure chaussuresCouleurPointure;

    private BigDecimal prix;

    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class PrixChaussuresDetailsId implements Serializable {
        private Integer idChaussuresCouleurPointure;
        private LocalDateTime datePrix;
    }
}
