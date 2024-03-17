-- data.sql

-- Create the uuid extension
-- Create the uuid extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create the enum user_type
CREATE TYPE user_type AS ENUM ('admin', 'neighbor');

-- Create the table communities
CREATE TABLE IF NOT EXISTS communities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    community_name VARCHAR(255) NOT NULL,
    community_code VARCHAR(8) UNIQUE NOT NULL
);

-- Create the table users
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL,
    image_url VARCHAR(2048) NOT NULL,
    balance INT NOT NULL,
    type user_type NOT NULL,
    community_id UUID,  -- Reference to the community this user belongs to, allows NULL
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE SET NULL -- Allows user to be unassigned from a community
);

-- Insert some sample data
INSERT INTO users (password, email, username, image_url, balance, type)
VALUES
    ('1234', 'joedoe@example.com', 'JoeDoe', 'https://example.com/joedoe.jpg', 0, 'admin'),
    ('5678', 'janedoe@example.com', 'JaneDoe', 'https://example.com/janedoe.jpg', 100, 'neighbor');