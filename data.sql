CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE user_type AS ENUM ('admin', 'neighbor');

CREATE TYPE service_status AS ENUM ('open', 'closed');

CREATE TYPE service_type AS ENUM ('requested', 'offered');

CREATE TYPE notification_status AS ENUM ('pending', 'accepted', 'refused');

CREATE TYPE achievement_status AS ENUM ('completed', 'claimed', 'in_progress');

CREATE TABLE IF NOT EXISTS communities (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name VARCHAR(255) NOT NULL,
	code VARCHAR(8) UNIQUE NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	community_id uuid not null references communities(id) on delete cascade,
	username VARCHAR(100) UNIQUE NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	type user_type NOT NULL,
	balance INT NOT NULL DEFAULT 50,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS services (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	creator_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
	buyer_id UUID DEFAULT NULL REFERENCES users(id) ON DELETE
	SET
		NULL,
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
	sender_id UUID REFERENCES users(id) ON DELETE
	SET
		NULL,
		service_id UUID REFERENCES services(id) ON DELETE
	SET
		NULL,
		status notification_status DEFAULT 'pending',
		created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ratings (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	service_id UUID UNIQUE REFERENCES services(id) ON DELETE cascade,
	rating INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE achievements (
	title VARCHAR(100) PRIMARY KEY,
	description TEXT,
	reward INT
);

CREATE TABLE user_achievements (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	user_id UUID REFERENCES users(id),
	achievement_title VARCHAR(100) REFERENCES achievements(title),
	status achievement_status NOT NULL DEFAULT 'in_progress'
);

INSERT INTO
	achievements (title, description, reward)
VALUES
	(
		'Service Showcase: Unveiling 5 Offerings to the World!',
		'create 5 type services offered.',
		30
	),
	(
		'Service Spectrum: Fulfilling 5 Requested Offerings!',
		'create 5 type services requested.',
		30
	),
	(
		'Neighborhood Pioneer: Initiate 1 Service Exchange',
		'create your first service.',
		15
	),
	(
		'Neighbor Nexus: Welcome 5 Service Offers with Open Arms',
		'accept 5 services.',
		60
	),
	(
		'Community Cohesion: Engage in 5 Vibrant Service Interactions',
		'get 5 services accepted. ',
		100
	);
