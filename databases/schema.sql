-- Script SQL pour PostgreSQL généré à partir de base.txt

-- Table GENRE
CREATE TABLE IF NOT EXISTS genre (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table MARQUE
CREATE TABLE IF NOT EXISTS marque (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table COUPE
CREATE TABLE IF NOT EXISTS coupe (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table CATEGORIES
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table COULEUR
CREATE TABLE IF NOT EXISTS couleur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    majoration_pourcentage NUMERIC(5, 2) DEFAULT 0
);

-- Table POINTURE
CREATE TABLE IF NOT EXISTS pointure (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    p_eur NUMERIC(5, 2),
    p_us NUMERIC(5, 2),
    p_uk NUMERIC(5, 2)
);

-- Table CLIENTS
CREATE TABLE IF NOT EXISTS clients (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

-- Table TYPE_MVTSTOCK
CREATE TABLE IF NOT EXISTS type_mvtstock (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table CHAUSSURES
CREATE TABLE IF NOT EXISTS chaussures (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    id_coupe INT REFERENCES coupe(id),
    id_marque INT REFERENCES marque(id),
    prix NUMERIC(15, 2)
);

-- Table CHAUSSURES_GENRES
CREATE TABLE IF NOT EXISTS chaussures_genres (
    id_chaussure_genre SERIAL PRIMARY KEY,
    id_chaussure INT REFERENCES chaussures(id),
    id_genre INT REFERENCES genre(id),
    id_categories INT REFERENCES categories(id),
    prix NUMERIC(15, 2)
);

-- Table PRIX_CHAUSSURESGENRESDETAILS
CREATE TABLE IF NOT EXISTS prix_chaussuresgenredetails (
    id_chaussure_genre INT REFERENCES chaussures_genres(id_chaussure_genre),
    prix NUMERIC(15, 2),
    date_prix TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_chaussure_genre, date_prix)
);

-- Table CHAUSSURES_COULEUR_POINTURE
CREATE TABLE IF NOT EXISTS chaussures_couleur_pointure (
    id SERIAL PRIMARY KEY,
    id_chaussure_genre INT REFERENCES chaussures_genres(id_chaussure_genre),
    id_couleur INT REFERENCES couleur(id),
    id_pointure INT REFERENCES pointure(id),
    prix NUMERIC(15, 2)
);

-- Table PRIX_CHAUSSURES
CREATE TABLE IF NOT EXISTS prix_chaussures (
    id_chaussures INT REFERENCES chaussures(id),
    prix NUMERIC(15, 2),
    date_prix TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_chaussures, date_prix)
);

-- Table PRIX_CHAUSSURESDETAILS
CREATE TABLE IF NOT EXISTS prix_chaussuresdetails (
    id_chaussures_couleur_pointure INT REFERENCES chaussures_couleur_pointure(id),
    prix NUMERIC(15, 2),
    date_prix TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_chaussures_couleur_pointure, date_prix)
);

-- Table STOCK
-- Note: id_chaussures_couleur_pointure a été ajouté pour lier le stock aux produits
CREATE TABLE IF NOT EXISTS stock (
    id SERIAL PRIMARY KEY,
    id_chaussures_couleur_pointure INT REFERENCES chaussures_couleur_pointure(id),
    id_type_mvtstock INT REFERENCES type_mvtstock(id),
    quantite INT NOT NULL,
    date_mvt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table COMMANDES
CREATE TABLE IF NOT EXISTS commandes (
    id SERIAL PRIMARY KEY,
    id_client INT REFERENCES clients(id),
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table COMMANDES_DETAILS
CREATE TABLE IF NOT EXISTS commandes_details (
    id_cd SERIAL PRIMARY KEY,
    id_commande INT REFERENCES commandes(id),
    id_chaussures_couleur_pointure INT REFERENCES chaussures_couleur_pointure(id),
    quantite INT NOT NULL,
    prix NUMERIC(15, 2) NOT NULL
);

-- Table REMISE
CREATE TABLE IF NOT EXISTS remise (
    id SERIAL PRIMARY KEY,
    quantite INT NOT NULL,
    remise NUMERIC(5, 2) NOT NULL,
    date_remise TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table LIEU
CREATE TABLE IF NOT EXISTS lieu (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table FRAIS_LIVRAISON
CREATE TABLE IF NOT EXISTS frais_livraison (
    id_lieu INT REFERENCES lieu(id),
    montant NUMERIC(15, 2) NOT NULL,
    date_frais TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_lieu, date_frais)
);

-- Modification table COMMANDES
ALTER TABLE commandes ADD COLUMN id_lieu INT REFERENCES lieu(id);

-- Dans schema.sql
ALTER TABLE couleur ADD COLUMN majoration_pourcentage NUMERIC(5, 2) DEFAULT 0;