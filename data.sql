CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE user_type AS ENUM ('admin', 'neighbor');

CREATE TYPE service_status AS ENUM ('open', 'closed');

CREATE TYPE service_type AS ENUM ('requested', 'offered');

CREATE TYPE notification_status AS ENUM ('pending', 'accepted', 'refused');

CREATE TABLE IF NOT EXISTS communities (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name VARCHAR(255) NOT NULL,
	code VARCHAR(8) UNIQUE NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
	username VARCHAR(100) UNIQUE NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	type user_type NOT NULL,
	balance INT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS services (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	community_id UUID NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
	creator_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
	buyer_id UUID DEFAULT NULL REFERENCES users(id) ON DELETE SET NULL,
	title VARCHAR(255) NOT NULL,
	description VARCHAR(2048),
	price INT NOT NULL,
	status service_status NOT NULL DEFAULT 'open',
	type service_type NOT NULL,
	image_url VARCHAR(2048) DEFAULT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS notifications (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	sender_id UUID REFERENCES users(id) ON DELETE SET NULL,
	receiver_id UUID REFERENCES users(id) ON DELETE SET NULL,
	service_id UUID REFERENCES services(id) ON DELETE SET NULL,
	status notification_status DEFAULT 'pending',
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
