-- data.sql

-- Crear la tabla users
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insertar algunos datos de ejemplo
INSERT INTO users (username, email) VALUES
    ('usuario1', 'usuario1@example.com'),
    ('usuario2', 'usuario2@example.com');
