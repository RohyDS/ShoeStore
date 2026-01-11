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
INSERT INTO couleur (nom) VALUES 
('Noir'), 
('Blanc'), 
('Bleu'), 
('Rouge'), 
('Gris'), 
('Vert');

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
('Air Max 270', 1, 1, 150.00),
('Stan Smith', 1, 2, 100.00),
('UltraBoost', 1, 2, 180.00),
('Suede Classic', 1, 3, 85.00),
('Speedcross 5', 2, 5, 130.00);

-- Insertion dans CHAUSSURES_GENRES
-- Chaussure 1 (Air Max) : Masculin (1), adultes (3)
-- Chaussure 2 (Stan Smith) : Feminin (2), jeune (2)
INSERT INTO chaussures_genres (id_chaussure, id_genre, id_categories) VALUES 
(1, 1, 3),
(2, 2, 2),
(3, 1, 3),
(4, 2, 2),
(5, 1, 1);

-- Insertion dans CHAUSSURES_COULEUR_POINTURE
-- id_chaussure_genre, Noir (1), 42 (5)
-- id_chaussure_genre, Blanc (2), 43 (6)
-- id_chaussure_genre, Blanc (2), 40 (3)
INSERT INTO chaussures_couleur_pointure (id_chaussure_genre, id_couleur, id_pointure, prix) VALUES 
(1, 1, 5, 150.00),
(1, 2, 6, 150.00),
(2, 2, 3, 100.00),
(3, 3, 5, 180.00),
(4, 4, 2, 85.00),
(5, 5, 4, 130.00);

-- Insertion dans PRIX_CHAUSSURES (Historique des prix globaux)
INSERT INTO prix_chaussures (id_chaussures, prix, date_prix) VALUES 
(1, 140.00, '2025-12-01 10:00:00'),
(1, 150.00, CURRENT_TIMESTAMP),
(2, 95.00, '2025-12-01 10:00:00'),
(2, 100.00, CURRENT_TIMESTAMP);

-- Insertion dans PRIX_CHAUSSURESDETAILS (Historique des prix spécifiques)
INSERT INTO prix_chaussuresdetails (id_chaussures_couleur_pointure, prix, date_prix) VALUES 
(1, 145.00, '2025-12-01 10:00:00'),
(1, 150.00, CURRENT_TIMESTAMP),
(3, 90.00, '2025-12-01 10:00:00'),
(3, 100.00, CURRENT_TIMESTAMP);
