INSERT INTO communities (name, code) VALUES ('Test Community', '12345678');

INSERT INTO users (community_id, username, email, password, type, balance) VALUES
	((SELECT id FROM communities WHERE code = '12345678'), 'JohnDoe', 'johndoe@example.com', 'Test1234!', 'admin', 1000),
	((SELECT id FROM communities WHERE code = '12345678'), 'JaneDoe', 'janedoe@example.com', 'Test1234!', 'neighbor', 0),
	((SELECT id FROM communities WHERE code = '12345678'), 'TomSmith', 'tomsmith@example.com', 'Test1234!', 'neighbor', 253),
	((SELECT id FROM communities WHERE code = '12345678'), 'AmyAdams', 'amyadams@example.com', 'Test1234!', 'neighbor', 741);
	
INSERT INTO services (creator_id, title, description, price, type) VALUES
    ((SELECT id FROM users WHERE email = 'johndoe@example.com'), 'Do Laundry', 'Hey there! Looking for someone to lend a hand with laundry duty. My washer just decided to call it quits, and I''m drowning in dirty clothes.', 10, 'requested'),
    ((SELECT id FROM users WHERE email = 'janedoe@example.com'), 'Walk Dogs', 'If you''re in need of a helping hand (or paw) to walk your furry friend, I''m your person! With a passion for pups and plenty of free time, I''m available to take your canine companion on a stroll around the neighborhood.', 15, 'offered'),
    ((SELECT id FROM users WHERE email = 'tomsmith@example.com'), 'Repair Laptop', 'Anyone out there handy with laptops? Mine''s acting up and I''m lost without it. If you know your way around hardware and software, I''d really appreciate a hand getting this thing back in action.', 45, 'requested');
