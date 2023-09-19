/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name  = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROm animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;



BEGIN; 
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


BEGIN; 
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_animals;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;