/*Queries that provide answers to the questions from all projects.*/

-- DAY 1

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name  = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROm animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


--DAY 2

SELECT COUNT (*) FROM animals;

SELECT COUNT (*) FROM animals WHERE escape_attempts < 1;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) AS escape_average FROM animals GROUP BY (neutered);

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;



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


-- DAY 3

SELECT name AS animal, owners.full_name AS owner
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.id = 4;

SELECT animals.name AS is_pokemon
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.id = 1;

SELECT full_name AS owner, animals.name AS animal
FROM owners
LEFT JOIN animals
ON owners.id = owner_id;

SELECT species.name AS species,COUNT(*)
FROM species
INNER join animals
ON species.id = species_id
GROUP BY species.name;

SELECT animals.name AS animal , full_name AS owner , species.name AS species
FROM animals
INNER JOIN owners
ON owner_id = owners.id
INNER JOIN species
ON species_id = species.id
WHERE owner_id = 2 AND species_id = 1;

SELECT animals.name
FROM animals
INNER JOIN owners
ON owner_id = owners.id
WHERE owner_id = 5 AND escape_attempts = 0;

SELECT subq.full_name, MAX(subq.owned)
FROM (
SELECT owners.full_name, COUNT(*) AS owned
FROM owners
INNER JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
)AS subq
GROUP BY subq.full_name
ORDER BY MAX(subq.owned) desc
LIMIT 1;


--DAY 4

SELECT subq.last_date_of_visit, vets.name AS vet , animals.name AS animal
FROM (
SELECT MAX(date_of_visit) AS last_date_of_visit, vets_id
FROM visits
WHERE vets_id = 1
GROUP BY vets_id 
) AS subq
INNER JOIN vets ON subq.vets_id = vets.id
INNER JOIN visits ON subq.last_date_of_visit = visits.date_of_visit AND subq.vets_id = visits.vets_id
INNER JOIN animals ON visits.animals_id = animals.id;


SELECT COUNT(DISTINCT animals_id)
FROM visits
WHERE vets_id = 3;


SELECT vets.name, species.name AS speciality
FROM vets
LEFT JOIN specializations
ON vets_id = vets.id
LEFT JOIN species
ON species_id = species.id
GROUP BY vets.name, species.name;


SELECT animals.name AS animal, date_of_visit
FROM visits
INNER JOIN animals
ON animals_id = animals.id
WHERE date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-01' AND vets_id = 3;


SELECT animals.name AS animal, MAX(subq.all_count) AS max_visits
FROM (
  SELECT animals_id, COUNT(*) AS all_count
  FROM visits
  GROUP BY animals_id
) AS subq
INNER JOIN animals ON subq.animals_id = animals.id
GROUP BY animals.name
ORDER BY MAX(subq.all_count) desc
LIMIT 1;


SELECT subq.last_date_of_visit, vets.name AS vet , animals.name AS animal
FROM (
SELECT MIN(date_of_visit) AS last_date_of_visit, vets_id
FROM visits
WHERE vets_id = 2
GROUP BY vets_id 
) AS subq
INNER JOIN vets ON subq.vets_id = vets.id
INNER JOIN visits ON subq.last_date_of_visit = visits.date_of_visit AND subq.vets_id = visits.vets_id
INNER JOIN animals ON visits.animals_id = animals.id;


SELECT 
subq.last_date_of_visit AS date, 
vets.name AS vet , 
animals.name AS animal, 
species.name AS species,
vets.age AS vet_age,
vets.date_of_graduation AS vet_graduation_date
FROM (
SELECT MAX(date_of_visit) AS last_date_of_visit, vets_id
FROM visits
GROUP BY vets_id 
) AS subq
INNER JOIN vets ON subq.vets_id = vets.id 
INNER JOIN visits ON subq.last_date_of_visit = visits.date_of_visit AND subq.vets_id = visits.vets_id
INNER JOIN animals ON visits.animals_id = animals.id
INNER JOIN species ON animals.species_id = species.id
ORDER BY subq.last_date_of_visit desc
LIMIT 1;


SELECT COUNT(num_visits)
FROM (
  SELECT
  FROM visits
  INNER JOIN animals ON visits.animals_id = animals.id
  INNER JOIN vets ON vets_id = vets.id
  WHERE vets.id NOT IN (
    SELECT specializations.vets_id
    FROM specializations
    WHERE specializations.species_id = animals.species_id
) 
) AS num_visits;


SELECT COUNT(animals.species_id) AS more_visits_from, species.name FROM visits 
INNER JOIN animals ON visits.animals_id = animals.id
INNER JOIN vets ON visits.vets_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets_id = 2
GROUP BY animals.species_id, species.name
ORDER BY more_visits_from DESC
LIMIT 1;




