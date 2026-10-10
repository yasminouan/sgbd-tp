-- ============================================================
-- TP1 : Rappel & Consolidation SQL
-- Partie I : DDL et contraintes (SGBD : Oracle)
-- ============================================================

-- Q1 : Création des tables
CREATE TABLE Agriculteur (
    agriculteur_id        NUMBER PRIMARY KEY,
    nom                   VARCHAR2(100),
    wilaya                VARCHAR2(50),
    superficie_ha         NUMBER,
    irrigation_economique VARCHAR2(3)
);

CREATE TABLE Produit_Alimentaire (
    produit_id          NUMBER PRIMARY KEY,
    nom                 VARCHAR2(100),
    categorie           VARCHAR2(50),
    apport_kcal_100g    NUMBER,
    empreinte_eau_l_kg  NUMBER
);

CREATE TABLE Lot_Production (
    lot_id               NUMBER PRIMARY KEY,
    agriculteur_id       NUMBER,
    produit_id           NUMBER,
    quantite_produite_kg NUMBER,
    saison_annee         VARCHAR2(30),
    cout_production_da   NUMBER,
    CONSTRAINT fk_lot_agriculteur FOREIGN KEY (agriculteur_id) REFERENCES Agriculteur(agriculteur_id),
    CONSTRAINT fk_lot_produit     FOREIGN KEY (produit_id)     REFERENCES Produit_Alimentaire(produit_id)
);

-- Alternative : ajouter la clé étrangère après la création de la table
-- ALTER TABLE Lot_Production ADD CONSTRAINT fk_lot_agriculteur
--     FOREIGN KEY (agriculteur_id) REFERENCES Agriculteur(agriculteur_id);

CREATE TABLE Marche (
    marche_id                NUMBER PRIMARY KEY,
    nom                      VARCHAR2(100),
    wilaya                   VARCHAR2(50),
    type_marche              VARCHAR2(30),
    capacite_stockage_tonnes NUMBER
);

CREATE TABLE Approvisionnement (
    appro_id               NUMBER PRIMARY KEY,
    lot_id                 NUMBER,
    marche_id              NUMBER,
    date_appro             DATE,
    quantite_livree_kg     NUMBER,
    prix_vente_unitaire_da NUMBER,
    CONSTRAINT fk_appro_lot    FOREIGN KEY (lot_id)    REFERENCES Lot_Production(lot_id),
    CONSTRAINT fk_appro_marche FOREIGN KEY (marche_id) REFERENCES Marche(marche_id)
);

-- Q2 : Contraintes d'intégrité métier
ALTER TABLE Agriculteur
    ADD CONSTRAINT ck_irrigation CHECK (irrigation_economique IN ('OUI', 'NON'));

ALTER TABLE Marche
    ADD CONSTRAINT ck_type_marche
    CHECK (type_marche IN ('gros', 'detail', 'national', 'reserve_strategique'));

ALTER TABLE Lot_Production
    ADD CONSTRAINT ck_quantite_produite CHECK (quantite_produite_kg > 0);

ALTER TABLE Approvisionnement
    ADD CONSTRAINT ck_quantite_livree CHECK (quantite_livree_kg > 0);

ALTER TABLE Approvisionnement
    ADD CONSTRAINT ck_prix_vente CHECK (prix_vente_unitaire_da > 0);

ALTER TABLE Lot_Production MODIFY cout_production_da DEFAULT 0;

-- Q3 : Évolution de structure
ALTER TABLE Agriculteur ADD telephone VARCHAR2(15);

ALTER TABLE Agriculteur MODIFY nom VARCHAR2(100) NOT NULL;

-- Pourquoi NOT NULL peut échouer sur une table contenant déjà des lignes ?
-- Si certaines lignes ont déjà NULL dans la colonne, Oracle refuse la contrainte.
-- Il faut d'abord remplir les valeurs NULL avec un UPDATE, puis ajouter NOT NULL.
-- UPDATE Agriculteur SET telephone = ' ' WHERE telephone IS NULL;
ALTER TABLE Agriculteur MODIFY telephone VARCHAR2(15) NOT NULL;

ALTER TABLE Marche MODIFY nom VARCHAR2(100);

ALTER TABLE Agriculteur RENAME COLUMN telephone TO num_contact;

ALTER TABLE Agriculteur DROP COLUMN num_contact;
