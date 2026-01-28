-- Script SQL pour PostgreSQL généré à partir de base.txt

-- Réinitialisation de la base de données
DROP TABLE IF EXISTS evenements_promos CASCADE;
DROP TABLE IF EXISTS retours CASCADE;
DROP TABLE IF EXISTS remise CASCADE;
DROP TABLE IF EXISTS commandes_details CASCADE;
DROP TABLE IF EXISTS commandes CASCADE;
DROP TABLE IF EXISTS frais_livraison CASCADE;
DROP TABLE IF EXISTS lieu CASCADE;
DROP TABLE IF EXISTS stock CASCADE;
DROP TABLE IF EXISTS prix_chaussuresdetails CASCADE;
DROP TABLE IF EXISTS prix_chaussures CASCADE;
DROP TABLE IF EXISTS chaussures_couleur_pointure CASCADE;
DROP TABLE IF EXISTS prix_chaussuresgenredetails CASCADE;
DROP TABLE IF EXISTS chaussures_genres CASCADE;
DROP TABLE IF EXISTS chaussures CASCADE;
DROP TABLE IF EXISTS type_mvtstock CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS pointure CASCADE;
DROP TABLE IF EXISTS couleur CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS coupe CASCADE;
DROP TABLE IF EXISTS marque CASCADE;
DROP TABLE IF EXISTS genre CASCADE;

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
    prix NUMERIC(15, 2) NOT NULL,
    id_lieu INT REFERENCES lieu(id)
);

-- Table REMISE
CREATE TABLE IF NOT EXISTS remise (
    id SERIAL PRIMARY KEY,
    quantite INT NOT NULL,
    remise NUMERIC(5, 2) NOT NULL,
    date_remise TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table EVENEMENTS_PROMOS
CREATE TABLE IF NOT EXISTS evenements_promos (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    id_chaussure_genre INT REFERENCES chaussures_genres(id_chaussure_genre),
    remise NUMERIC(5, 2) NOT NULL,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL
);

-- Table RETOURS
CREATE TABLE IF NOT EXISTS retours (
    id SERIAL PRIMARY KEY,
    id_cd INT REFERENCES commandes_details(id_cd),
    quantite INT NOT NULL,
    montant_rembourse NUMERIC(15, 2) NOT NULL,
    motif TEXT,
    date_retour TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Script de données de test pour PostgreSQL

-- Insertion dans GENRE
INSERT INTO genre (nom) VALUES 
('Masculin'), 
('Feminin');

-- Insertion dans CATEGORIES
INSERT INTO categories (nom) VALUES 
('enfants'), 
('jeune'), 
('adultes');

-- Insertion dans COUPE
INSERT INTO coupe (nom) VALUES 
('Basse'), 
('Montante'), 
('Moyenne');

-- Insertion dans COULEUR
INSERT INTO couleur (nom, majoration_pourcentage) VALUES 
('Noir', 0), 
('Blanc', 0), 
('Bleu', 0), 
('Rouge', 0), 
('Gris', 0), 
('Vert', 0);

-- Insertion dans POINTURE
INSERT INTO pointure (nom, p_eur, p_us, p_uk) VALUES 
('38', 38, 5.5, 5),
('39', 39, 6.5, 6),
('40', 40, 7.5, 7),
('41', 41, 8.5, 8),
('42', 42, 9, 8.5),
('43', 43, 10, 9.5),
('44', 44, 10.5, 10);

-- Insertion dans MARQUE
INSERT INTO marque (nom) VALUES 
('Nike'), 
('Adidas'), 
('Puma'), 
('Reebok'), 
('Salomon');

-- Insertion dans CLIENTS
INSERT INTO clients (nom) VALUES 
('Jean Dupont'), 
('Marie Martin'), 
('Paul Bernard'), 
('Alice Petit');

-- Insertion dans TYPE_MVTSTOCK
INSERT INTO type_mvtstock (nom) VALUES 
('Entrée'), 
('Sortie');

-- Insertion dans CHAUSSURES
-- On suppose les IDs générés : 1:Nike, 2:Adidas, 3:Puma | 1:Basse, 2:Montante
INSERT INTO chaussures (nom, id_coupe, id_marque, prix) VALUES 
('Air Max 270', 1, 1, 150000.00),
('Stan Smith', 1, 2, 100000.00),
('UltraBoost', 1, 2, 180000.00),
('Suede Classic', 1, 3, 85000.00),
('Speedcross 5', 2, 5, 130000.00);

-- Insertion dans CHAUSSURES_GENRES
-- Chaussure 1 (Air Max) : Masculin (1), adultes (3)
-- Chaussure 2 (Stan Smith) : Feminin (2), jeune (2)
INSERT INTO chaussures_genres (id_chaussure, id_genre, id_categories, prix) VALUES 
(1, 1, 3, 145000.00),
(2, 2, 2, 95000.00),
(3, 1, 3, 175000.00),
(4, 2, 2, 80000.00),
(5, 1, 1, 125000.00);

-- Insertion dans PRIX_CHAUSSURESGENRESDETAILS
INSERT INTO prix_chaussuresgenredetails (id_chaussure_genre, prix, date_prix) VALUES 
(1, 140000.00, '2025-12-01 10:00:00'),
(1, 145000.00, CURRENT_TIMESTAMP),
(2, 90000.00, '2025-12-01 10:00:00'),
(2, 95000.00, CURRENT_TIMESTAMP);

-- Insertion dans CHAUSSURES_COULEUR_POINTURE
-- id_chaussure_genre, Noir (1), 42 (5)
-- id_chaussure_genre, Blanc (2), 43 (6)
-- id_chaussure_genre, Blanc (2), 40 (3)
INSERT INTO chaussures_couleur_pointure (id_chaussure_genre, id_couleur, id_pointure, prix) VALUES 
(1, 1, 5, 150000.00),
(1, 2, 6, 150000.00),
(2, 2, 3, 100000.00),
(3, 3, 5, 180000.00),
(4, 4, 2, 85000.00),
(5, 5, 4, 130000.00);

-- Insertion dans REMISE
INSERT INTO remise (quantite, remise) VALUES 
(1, 10.0),
(5, 20.0);

-- Insertion dans PRIX_CHAUSSURES (Historique des prix globaux)
INSERT INTO prix_chaussures (id_chaussures, prix, date_prix) VALUES 
(1, 140000.00, '2025-12-01 10:00:00'),
(1, 150000.00, CURRENT_TIMESTAMP),
(2, 95000.00, '2025-12-01 10:00:00'),
(2, 100000.00, CURRENT_TIMESTAMP);

-- Insertion dans PRIX_CHAUSSURESDETAILS (Historique des prix spécifiques)
INSERT INTO prix_chaussuresdetails (id_chaussures_couleur_pointure, prix, date_prix) VALUES 
(1, 145000.00, '2025-12-01 10:00:00'),
(1, 150000.00, CURRENT_TIMESTAMP),
(3, 90000.00, '2025-12-01 10:00:00'),
(3, 100000.00, CURRENT_TIMESTAMP);

-- Insertion dans LIEU
INSERT INTO lieu (nom) VALUES 
('Analamahitsy'),
('Ivandry'),
('Talatamaty'),
('Analakely');

-- Insertion dans FRAIS_LIVRAISON
INSERT INTO frais_livraison (id_lieu, montant, date_frais) VALUES 
(1, 2000.00, CURRENT_TIMESTAMP),
(2, 3000.00, CURRENT_TIMESTAMP),
(3, 5000.00, CURRENT_TIMESTAMP),
(4, 1500.00, CURRENT_TIMESTAMP);


-- Modification table COMMANDES
-- ALTER TABLE commandes ADD COLUMN id_lieu INT REFERENCES lieu(id);

