-- data.sql

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE notification_status AS ENUM ('PENDING', 'ACCEPTED', 'REFUSED');

CREATE TYPE service_status AS ENUM ('OPEN', 'CLOSED');

CREATE TYPE service_type AS ENUM ('REQUESTED', 'OFFERED');

CREATE TYPE user_type AS ENUM ('admin', 'neighbor');

CREATE TABLE IF NOT EXISTS communities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    community_name VARCHAR(255) NOT NULL,
    community_code VARCHAR(8) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    image_url VARCHAR(2048) NOT NULL,
    type user_type NOT NULL,  -- Tipo de usuario: 'admin' o 'neighbor'
    community_id UUID,  
    balance INT NOT NULL     DEFAULT 0,  -- Saldo del usuario
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    creator_id UUID REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price INT,
    status service_status DEFAULT 'OPEN', -- Estado del servicio: 'OPEN' o 'CLOSED'
    type service_type,
    buyer_user_id UUID,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID REFERENCES users(id),
    receiver_id UUID REFERENCES users(id),  
    service_id UUID REFERENCES services(id),
    status notification_status DEFAULT 'PENDING', -- PENDING, ACCEPTED, REFUSED
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

