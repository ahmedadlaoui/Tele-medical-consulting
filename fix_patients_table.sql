-- Script pour corriger la table patients
-- Ce script rend les colonnes optionnelles nullable pour correspondre à l'entité Patient

USE med_consulting;

-- Rendre socialSecurityNumber nullable (c'est la cause principale de l'erreur)
ALTER TABLE patients MODIFY COLUMN socialSecurityNumber VARCHAR(255) NULL;

-- Rendre insuranceProvider nullable aussi (optionnel dans l'entité)
ALTER TABLE patients MODIFY COLUMN insuranceProvider VARCHAR(255) NULL;

-- Vérifier la structure finale
DESCRIBE patients;

