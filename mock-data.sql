INSERT INTO communities (community_name, community_code) VALUES ('Test Community', '12345678');

INSERT INTO users (username, email, password, type, community_id, balance) VALUES
	('JohnDoe', 'johndoe@example.com', 'Test1234!', 'admin', '12345678', 1000),
	('JaneDoe', 'janedoe@example.com', 'Test1234!', 'neighbor', '12345678', 0);
	('Tom_Smith', 'tomsmith@example.com', 'Test1234!', 'neighbor', '12345678', 253);
	('Amy Adams', 'amyadams@example.com', 'Test1234!', 'neighbor', '12345678', 741);
