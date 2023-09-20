/* Database schema to keep the structure of entire database. */

-- DAY 1

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL,
    species VARCHAR(100)
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