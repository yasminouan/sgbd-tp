# TP1 : Rappel & Consolidation SQL

TP du module **Architecture & Administration de Bases de Données** (SGBD : Oracle).

## Contexte

Base de données de suivi de la sécurité et de la souveraineté alimentaire : cycles de production agricole, gestion de l'eau et acheminement des produits vers les marchés.

## Schéma relationnel

- **Agriculteur** (agriculteur_id, nom, wilaya, superficie_ha, irrigation_economique)
- **Produit_Alimentaire** (produit_id, nom, categorie, apport_kcal_100g, empreinte_eau_l_kg)
- **Lot_Production** (lot_id, #agriculteur_id, #produit_id, quantite_produite_kg, saison_annee, cout_production_da)
- **Marche** (marche_id, nom, wilaya, type_marche, capacite_stockage_tonnes)
- **Approvisionnement** (appro_id, #lot_id, #marche_id, date_appro, quantite_livree_kg, prix_vente_unitaire_da)

## Compétences travaillées

- DDL : création de tables, clés primaires et étrangères, `ALTER TABLE`
- Contraintes d'intégrité : `CHECK`, `NOT NULL`, `DEFAULT`
- DML : `INSERT`, `DELETE`, `COMMIT`
- Analyse des erreurs d'intégrité (ORA-02291, ORA-02290)

## Contenu

| Fichier | Description |
|---|---|
| `01_ddl_creation.sql` | Partie I : création des tables, contraintes, évolution de structure |
| `02_dml_insertion.sql` | Partie II : insertion des données, analyse des erreurs, nettoyage |

## Exécution

Exécuter les fichiers dans l'ordre (`01` puis `02`) sur Oracle.
