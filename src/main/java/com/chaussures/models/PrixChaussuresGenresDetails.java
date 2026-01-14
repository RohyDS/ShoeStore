package com.chaussures.models;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "prix_chaussuresgenredetails")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PrixChaussuresGenresDetails {

    @EmbeddedId
    private PrixChaussuresGenresDetailsId id;

    @ManyToOne
    @MapsId("idChaussureGenre")
    @JoinColumn(name = "id_chaussure_genre")
    private ChaussuresGenres chaussuresGenres;

    private BigDecimal prix;

    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class PrixChaussuresGenresDetailsId implements Serializable {
        private Integer idChaussureGenre;
        private LocalDateTime datePrix;
    }
}
