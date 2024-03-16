-- data.sql

-- Create the uuid extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create the enum user_type
CREATE TYPE user_type AS ENUM ('admin', 'neighbor');

-- Create the table users
CREATE TABLE IF NOT EXISTS users (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	password VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	username VARCHAR(50) UNIQUE NOT NULL,
	image_url VARCHAR(2048) NOT NULL,
	balance int NOT NULL,
	type user_type NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO users (password, email, username, image_url, balance, type)
VALUES
	('1234', 'joedoe@example.com', 'JoeDoe', 'https://example.com/joedoe.jpg', 0, 'admin'),
	('5678', 'janedoe@example.com', 'JaneDoe', 'https://example.com/janedoe.jpg', 100, 'neighbor');
