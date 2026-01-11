package com.chaussures.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "chaussures_genres")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChaussuresGenres {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_chaussure_genre")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_chaussure")
    private Chaussures chaussure;

    @ManyToOne
    @JoinColumn(name = "id_genre")
    private Genre genre;

    @ManyToOne
    @JoinColumn(name = "id_categories")
    private Categories categories;
}
