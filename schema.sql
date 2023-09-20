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
    owener_id INT 
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