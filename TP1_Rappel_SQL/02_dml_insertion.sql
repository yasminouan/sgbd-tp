-- ============================================================
-- TP1 : Rappel & Consolidation SQL
-- Partie II : DML, ingestion de données et analyse des anomalies
-- ============================================================
-- Table Agriculteur
INSERT INTO Agriculteur VALUES (1, 'Benali Ahmed', 'Blida', 5.5, 'OUI');
INSERT INTO Agriculteur VALUES (2, 'Khelifi Samira', 'Sétif', 12.0, 'NON');
INSERT INTO Agriculteur VALUES (3, 'Touati Mourad', 'Mostaganem', 8.0, 'OUI');
INSERT INTO Agriculteur VALUES (4, 'Zerrouki Fatma', 'Tizi Ouzou', 3.5, 'NON');
INSERT INTO Agriculteur VALUES (5, 'Bensaid Rachid', 'Biskra', 25.0, 'OUI');

-- Table Produit_Alimentaire
INSERT INTO Produit_Alimentaire VALUES (1, 'Blé dur HD1220', 'Céréale', 340, 1300);
INSERT INTO Produit_Alimentaire VALUES (2, 'Tomate sous serre', 'Légume', 18, 214);
INSERT INTO Produit_Alimentaire VALUES (3, 'Pomme de terre', 'Tubercule', 77, 287);
INSERT INTO Produit_Alimentaire VALUES (4, 'Huile d''Olive Extra', 'Oléagineux', 884, 3900);
INSERT INTO Produit_Alimentaire VALUES (5, 'Dattes Deglet Nour', 'Fruit', 277, 2000);

-- Table Lot_Production
INSERT INTO Lot_Production VALUES (101, 2, 1, 30000, 'Ete_2024', 450000);
INSERT INTO Lot_Production VALUES (102, 1, 2, 15000, 'Printemps_2024', 200000);
INSERT INTO Lot_Production VALUES (103, 3, 3, 20000, 'Hiver_2024', 310000);
INSERT INTO Lot_Production VALUES (104, 4, 4, 8000, 'Automne_2024', 500000);
INSERT INTO Lot_Production VALUES (105, 5, 5, 25000, 'Automne_2024', 900000);

-- ERREUR VOLONTAIRE : le lot 106 référence l'agriculteur 7, qui n'existe pas.
-- Erreur renvoyée : ORA-02291: integrity constraint (fk_lot_agriculteur) violated - parent key not found
-- Cause : la clé étrangère fk_lot_agriculteur (Lot_Production -> Agriculteur).
-- INSERT INTO Lot_Production VALUES (106, 7, 5, 12000, 'Automne_2024', 400000);

-- Table Marche
INSERT INTO Marche VALUES (1, 'Complexe Logistique Boufarik', 'Blida', 'gros', 5000);
INSERT INTO Marche VALUES (2, 'Marché Couvert Ali Ramli', 'Alger', 'detail', 200);

-- ERREUR VOLONTAIRE : 'grosss' n'est pas une valeur autorisée pour type_marche.
-- Erreur renvoyée : ORA-02290: check constraint (ck_type_marche) violated
-- Cause : la contrainte CHECK ck_type_marche.
-- INSERT INTO Marche VALUES (3, 'Plateforme Régionale Sétif', 'Sétif', 'grosss', 3000);

-- CORRECTION : le marché de Sétif est inséré avec le type valide 'gros'.
INSERT INTO Marche VALUES (3, 'Plateforme Régionale Sétif', 'Sétif', 'gros', 3000);

INSERT INTO Marche VALUES (4, 'Marché de Détail Mostaganem', 'Mostaganem', 'detail', 150);
INSERT INTO Marche VALUES (5, 'Pôle Export Tolga', 'Biskra', 'reserve_strategique', 10000);

-- Table Approvisionnement
INSERT INTO Approvisionnement VALUES (1, 101, 3, TO_DATE('07-01-2024','DD-MM-YYYY'), 10000, 60);
INSERT INTO Approvisionnement VALUES (2, 102, 1, TO_DATE('15-05-2024','DD-MM-YYYY'), 8000, 45);
INSERT INTO Approvisionnement VALUES (3, 103, 4, TO_DATE('20-01-2024','DD-MM-YYYY'), 12000, 50);
INSERT INTO Approvisionnement VALUES (4, 104, 2, TO_DATE('05-12-2024','DD-MM-YYYY'), 5000, 800);
INSERT INTO Approvisionnement VALUES (5, 105, 5, TO_DATE('11-03-2024','DD-MM-YYYY'), 15000, 350);

-- Donnée incohérente : date d'approvisionnement dans le futur (acceptée par la base, supprimée ci-dessous).
INSERT INTO Approvisionnement VALUES (6, 105, 5, TO_DATE('30-12-2027','DD-MM-YYYY'), 15000, 360);

-- Nettoyage : suppression des approvisionnements dont la date est postérieure à aujourd'hui
DELETE FROM Approvisionnement
WHERE date_appro > SYSDATE;

-- Validation de la transaction
COMMIT;
