/* Database schema to keep the structure of entire database. */

-- DAY 1

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    species_id INT 
    owner_id INT 
    Foreign-key constraints:
        "fk_owner_id" FOREIGN KEY (owner_id) REFERENCES owners(id)
        "fk_species_id" FOREIGN KEY (species_id) REFERENCES species(id)
);


-- DAY 3

CREATE TABLE owners (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50)
);

--DAY 4

CREATE TABLE vets (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(100) NOT NULL,
age INT NOT NULL,
date_of_graduation DATE NOT NULL 
);

CREATE TABLE specializations (
species_id INT NOT NULL,
vets_id INT NOT NULL,
PRIMARY KEY (species_id, vets_id),
FOREIGN KEY (species_id) REFERENCES species(id),
FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits(
animals_id INT NOT NULL,
vets_id INT NOT NULL,
PRIMARY KEY (animals_id, vets_id),
FOREIGN KEY(animals_id) REFERENCES animals(id),
FOREIGN KEY(vets_id) REFERENCES vets(id)
);