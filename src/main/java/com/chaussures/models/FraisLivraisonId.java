package com.chaussures.models;

import lombok.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class FraisLivraisonId implements Serializable {
    private Integer lieu;
    private LocalDateTime dateFrais;
}
