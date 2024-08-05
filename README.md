# Universe Database

This database represents a simplified model of a universe, containing tables for galaxies, galaxy types, moons, planets, and stars. Below is a detailed description of the database schema and its contents.

It's from the [FreeCodeCamp Relational database course](https://www.freecodecamp.org/learn/relational-database/)

## Database Information

- **Database Name:** universe
- **Owner:** freecodecamp
- **Encoding:** UTF8
- **Collate:** C.UTF-8
- **Ctype:** C.UTF-8

## Tables and Sequences

### 1. galaxy

- **Description:** Contains information about different galaxies.
- **Columns:**
  - `galaxy_id` (integer, NOT NULL, PRIMARY KEY)
  - `name` (character varying(30), NOT NULL, UNIQUE)
  - `age_in_millions_of_years` (integer)
  - `galaxy_types_id` (integer, FOREIGN KEY)
  - `nickname` (text, NOT NULL, DEFAULT 'FOR ALL LIFE')
- **Sequence:** `galaxy_galaxy_id_seq`

### 2. galaxy_types

- **Description:** Contains different types of galaxies.
- **Columns:**
  - `galaxy_types_id` (integer, NOT NULL, PRIMARY KEY)
  - `name` (character varying(30), UNIQUE)
  - `nickname` (text, NOT NULL, DEFAULT 'The types')
- **Sequence:** `galaxy_types_galaxy_types_id_seq`

### 3. moon

- **Description:** Contains information about moons.
- **Columns:**
  - `moon_id` (integer, NOT NULL, PRIMARY KEY)
  - `name` (character varying(30), NOT NULL, UNIQUE)
  - `planet_id` (integer, FOREIGN KEY)
  - `is_satellite` (boolean, NOT NULL)
  - `nickname` (text, NOT NULL, DEFAULT 'Find out soon')
- **Sequence:** `moon_moon_id_seq`

### 4. planet

- **Description:** Contains information about planets.
- **Columns:**
  - `planet_id` (integer, NOT NULL, PRIMARY KEY)
  - `name` (character varying(30), NOT NULL, UNIQUE)
  - `has_life` (boolean, NOT NULL)
  - `star_id` (integer, FOREIGN KEY)
  - `nickname` (text, NOT NULL, DEFAULT 'Helium ball of gas')
- **Sequence:** `planet_planet_id_seq`

### 5. star

- **Description:** Contains information about stars.
- **Columns:**
  - `star_id` (integer, NOT NULL, PRIMARY KEY)
  - `name` (character varying(30), NOT NULL, UNIQUE)
  - `age_in_millions_of_years` (integer)
  - `distance_from_earth` (numeric(7,3))
  - `galaxy_id` (integer, FOREIGN KEY)
- **Sequence:** `star_star_id_seq`

## Constraints

- **Unique Constraints:**
  - `galaxy_name_key` on `galaxy(name)`
  - `galaxy_types_name_key` on `galaxy_types(name)`
  - `moon_name_key` on `moon(name)`
  - `planet_name_key` on `planet(name)`
  - `star_name_key` on `star(name)`

- **Primary Keys:**
  - `galaxy_pkey` on `galaxy(galaxy_id)`
  - `galaxy_types_pkey` on `galaxy_types(galaxy_types_id)`
  - `moon_pkey` on `moon(moon_id)`
  - `planet_pkey` on `planet(planet_id)`
  - `star_pkey` on `star(star_id)`

- **Foreign Keys:**
  - `galaxy_types_key` on `galaxy(galaxy_types_id)` references `galaxy_types(galaxy_types_id)`
  - `galaxy_key` on `star(galaxy_id)` references `galaxy(galaxy_id)`
  - `planet_key` on `moon(planet_id)` references `planet(planet_id)`
  - `star_key` on `planet(star_id)` references `star(star_id)`

## Data

### galaxy

- Example Entries:
  - (1, 'Milky way', 800, 1, 'FOR ALL LIFE')
  - (2, 'Andromeda', 700, 2, 'FOR ALL LIFE')

### galaxy_types

- Example Entries:
  - (1, 'homely', 'The types')
  - (2, 'hostile', 'The types')

### moon

- Example Entries:
  - (5, 'Moon 1', 6, true, 'Find out soon')
  - (6, 'Moon 2', 6, true, 'Find out soon')

### planet

- Example Entries:
  - (6, 'Mercury', false, 1, 'Helium ball of gas')
  - (7, 'Venus', false, 1, 'Helium ball of gas')

### star

- Example Entries:
  - (1, 'Sol', 20, 2500.000, 1)
  - (2, 'Solar', 20, 2500.000, 2)

## Sequences

- `galaxy_galaxy_id_seq` set to 7
- `galaxy_types_galaxy_types_id_seq` set to 3
- `moon_moon_id_seq` set to 24
- `planet_planet_id_seq` set to 18
- `star_star_id_seq` set to 6

## Notes

- The database schema includes constraints to ensure data integrity.
- Default values are provided for some columns to ensure consistency.
- The database is designed to model a simplified universe with relationships between galaxies, galaxy types, moons, planets, and stars.

## How to Use

1. **Setup the Database:**
   - Use the provided SQL file (`universe.sql`) to set up the database.
   - Ensure you have PostgreSQL installed and running.

2. **Load the Data:**
   - Execute the SQL file to create the schema and load the initial data.

3. **Query the Database:**
   - Use SQL queries to interact with the database and retrieve information about the universe.

## License

This database schema is provided by freecodecamp and is intended for educational purposes.
