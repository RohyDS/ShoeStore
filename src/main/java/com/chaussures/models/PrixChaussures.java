package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "prix_chaussures")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PrixChaussures {

    @EmbeddedId
    private PrixChaussuresId id;

    @ManyToOne
    @MapsId("idChaussures")
    @JoinColumn(name = "id_chaussures")
    private Chaussures chaussure;

    private BigDecimal prix;

    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class PrixChaussuresId implements Serializable {
        private Integer idChaussures;
        private LocalDateTime datePrix;
    }
}
