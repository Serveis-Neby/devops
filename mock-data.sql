INSERT INTO communities (community_name, community_code) VALUES ('Test Community', '12345678');

INSERT INTO users (community_id, username, email, password, type, balance) VALUES
	((SELECT id FROM communities WHERE community_code = '12345678'), 'JohnDoe', 'johndoe@example.com', 'Test1234!', 'admin', 1000),
	((SELECT id FROM communities WHERE community_code = '12345678'), 'JaneDoe', 'janedoe@example.com', 'Test1234!', 'neighbor', 0),
	((SELECT id FROM communities WHERE community_code = '12345678'), 'TomSmith', 'tomsmith@example.com', 'Test1234!', 'neighbor', 253),
	((SELECT id FROM communities WHERE community_code = '12345678'), 'AmyAdams', 'amyadams@example.com', 'Test1234!', 'neighbor', 741);
