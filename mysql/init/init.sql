use  eventhub_db;
CREATE TABLE `event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` binary(16) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `event_date` date NOT NULL,
  `people` int NOT NULL,
  `spend_time` int NOT NULL,
  PRIMARY KEY (`id`)
);
 CREATE TABLE `event_tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `star` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` binary(16) NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `user` (
  `id` binary(16) NOT NULL ,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `todo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `deadline` date NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `event_todo_rlation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `todo_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `tool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `qua` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `event_tool_rlation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `tool_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `progress_todo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `todo_id` int NOT NULL,
  PRIMARY KEY (`id`)
);


-- sample data
-- Users


INSERT INTO `user` (id,name) VALUES
(UNHEX(REPLACE(UUID(), '-', '')),'John Doe'),
(UNHEX(REPLACE(UUID(), '-', '')),'west'),
(UNHEX(REPLACE(UUID(), '-', '')),'Alice'),
(UNHEX(REPLACE(UUID(), '-', '')),'Bob'),
(UNHEX(REPLACE(UUID(), '-', '')),'peter'),
(UNHEX(REPLACE(UUID(), '-', '')),'Bella'),
(UNHEX(REPLACE(UUID(), '-', '')),'alex');

-- Events
INSERT INTO `event` (user_id, title, description, created_at, event_date, people,spend_time) VALUES
( (SELECT id FROM user WHERE name = 'John Doe'), 'Meeting', 'Discuss project updates', NOW(), '2023-12-01', 10,18000),
( (SELECT id FROM user WHERE name = 'west'), 'Party', 'Party with friends', NOW(), '2023-02-01', 100,3635), 
( (SELECT id FROM user WHERE name = 'Alice'), 'Conference', 'Discuss project updates', NOW(), '2023-10-11', 20,20000),
( (SELECT id FROM user WHERE name = 'Bob'), 'バーベーキュー', 'Party with friends', NOW(), '2023-03-21', 1240,21960),
( (SELECT id FROM user WHERE name = 'peter'), 'aa', 'Discuss project updates', NOW(), '2023-10-09', 1041,14144),
( (SELECT id FROM user WHERE name = 'Bella'), 'fff', 'Party with friends', NOW(), '2023-11-11', 910,1515161),
( (SELECT id FROM user WHERE name = 'alex'), 'ggg', 'Party with friends', NOW(), '2023-09-01', 510,3600);

-- Tags
INSERT INTO `tag` (word) VALUES
('work'),
('fun'),
('con'),
('bbq'),
('aa'),
('ff'),
('gg');

-- Event Tags
INSERT INTO `event_tag` (event_id, tag_id) VALUES
((SELECT id FROM event WHERE title = 'Meeting'), 1),
((SELECT id FROM event WHERE title = 'Meeting'), 3),
((SELECT id FROM event WHERE title = 'Party'), 5),
((SELECT id FROM event WHERE title = 'Party'), 3),
((SELECT id FROM event WHERE title = 'バーベーキュー'), 1),
((SELECT id FROM event WHERE title = 'aa'), 2),
((SELECT id FROM event WHERE title = 'fff'), 7),
((SELECT id FROM event WHERE title = 'Conference'), 3),
((SELECT id FROM event WHERE title = 'バーベーキュー'), 4),
((SELECT id FROM event WHERE title = 'aa'), 5),
((SELECT id FROM event WHERE title = 'fff'), 6),
((SELECT id FROM event WHERE title = 'ggg'), 4),
((SELECT id FROM event WHERE title = 'Party'), 2),
((SELECT id FROM event WHERE title = 'Party'), 4),
((SELECT id FROM event WHERE title = 'バーベーキュー'), 2),
((SELECT id FROM event WHERE title = 'aa'), 3),
((SELECT id FROM event WHERE title = 'fff'), 7),
((SELECT id FROM event WHERE title = 'Conference'), 3),
((SELECT id FROM event WHERE title = 'バーベーキュー'), 7),
((SELECT id FROM event WHERE title = 'aa'), 4),
((SELECT id FROM event WHERE title = 'fff'), 1),
((SELECT id FROM event WHERE title = 'ggg'), 7);

-- Stars
INSERT INTO `star` (user_id, event_id) VALUES
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting')),
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting')),
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting')),
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting')),
( (SELECT id FROM user WHERE name = 'west'), (SELECT id FROM event WHERE title = 'Party')),
( (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM event WHERE title = 'Conference')),
( (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM event WHERE title = 'バーベーキュー')),
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting')),
( (SELECT id FROM user WHERE name = 'west'), (SELECT id FROM event WHERE title = 'Party')),
( (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM event WHERE title = 'Conference')),
( (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM event WHERE title = 'バーベーキュー')),
( (SELECT id FROM user WHERE name = 'peter'), (SELECT id FROM event WHERE title = 'aa')),
( (SELECT id FROM user WHERE name = 'Bella'), (SELECT id FROM event WHERE title = 'fff')),
( (SELECT id FROM user WHERE name = 'alex'), (SELECT id FROM event WHERE title = 'ggg'));

-- Todos
INSERT INTO `todo` (title, deadline) VALUES
('Buy milk', '2023-12-01'),
('Buy eggs', '2023-12-01'),
('Buy bread', '2023-12-01'),
('Buy butter', '2023-12-01'),
('Buy cheese', '2023-12-01'),
('Buy meat', '2023-12-01'),
('Buy fish', '2023-12-01'),
('Buy vegetables', '2023-12-01'),
('Buy fruit', '2023-12-01'),
('Buy rice', '2023-12-01'),
('Buy pasta', '2023-12-01'),
('Buy sauce', '2023-12-01'),
('Buy spices', '2023-12-01'),
('Buy oil', '2023-12-01'),
('Buy vinegar', '2023-12-01'),
('Buy sugar', '2023-12-01'),
('Buy salt', '2023-12-01'),
('Buy pepper', '2023-12-01'),
('Buy coffee', '2023-12-01'),
('Buy tea', '2023-12-01'),
('Buy beer', '2023-12-01'),
('Buy wine', '2023-12-01'),
('Buy whiskey', '2023-12-01'),
('Buy vodka', '2023-12-01'),
('Buy gin', '2023-12-01'),
('Buy rum', '2023-12-01'),
('Buy juice', '2023-12-01'),
('Buy soda', '2023-12-01'),
('Buy water', '2023-12-01'),
('Buy detergent', '2023-12-01'),
('Buy soap', '2023-12-01'),
('Buy shampoo', '2023-12-01'),
('Buy conditioner', '2023-12-01'),
('Buy toothpaste', '2023-12-01'),
('Buy toothbrush', '2023-12-01'),
('Buy floss', '2023-12-01'),
('Buy mouthwash', '2023-12-01'),
('Buy toilet paper', '2023-12-01'),
('Buy paper towels', '2023-12-01'),
('Buy tissues', '2023-12-01');

-- Event Todo Relation
INSERT INTO `event_todo_rlation` (event_id, todo_id) VALUES
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy milk'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy eggs'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy bread'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy butter'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy cheese'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy meat'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fish'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy vegetables'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fruit'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy rice'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pasta'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy sauce'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy spices'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy oil'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy vinegar'),
((SELECT id FROM event WHERE title = 'aa'), SELECT id FROM todo WHERE title = 'Buy sugar'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy salt'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pepper'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy coffee'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy tea'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy beer'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy wine'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy whiskey'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy vodka'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy gin'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy rum'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy juice'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy soda'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy water'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy detergent'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy soap'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy shampoo'),
((SELECT id FROM event WHERE title = 'バーベーキュー'), SELECT id FROM todo WHERE title = 'Buy conditioner'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy toothpaste'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy toothbrush'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy floss'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy mouthwash'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy toilet paper'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy paper towels'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy tissues'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy milk'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy eggs'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy bread'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy butter'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy cheese'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy soap');

-- Tools
INSERT INTO `tool` (name, qua) VALUES
('ハンマー', 12),
('ドライバー', 4),
('ペンチ', 5),
('ノコギリ', 8),
('ヤスリ', 1),
('ハンドソー',4),
('ノギス', 1),
('メジャー', 1),
('コンパス', 1),
('ボールペン', 3),
('シャープペンシル', 1),
('鉛筆', 1),
('消しゴム', 3),
('定規', 1),
('三角定規', 1),
('コンパス', 2),
('ノート', 1),

-- Event Tool Relation
INSERT INTO `event_tool_rlation` (event_id, tool_id) VALUES
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy milk'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy eggs'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy bread'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy butter'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy cheese'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy meat'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fish'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy vegetables'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fruit'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy rice'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pasta'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy sauce'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy spices'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy oil'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy vinegar'),
((SELECT id FROM event WHERE title = 'aa'), SELECT id FROM todo WHERE title = 'Buy sugar'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy salt'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pepper'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy coffee'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy tea'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy beer'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy wine'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo

-- Progress Todo
INSERT INTO `progress_todo` (event_id, todo_id) VALUES
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy milk'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy eggs'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy bread'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy butter'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy cheese'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy meat'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fish'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy vegetables'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy fruit'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy rice'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pasta'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy sauce'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy spices'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy oil'),
((SELECT id FROM event WHERE title = 'Party'), SELECT id FROM todo WHERE title = 'Buy vinegar'),
((SELECT id FROM event WHERE title = 'aa'), SELECT id FROM todo WHERE title = 'Buy sugar'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy salt'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy pepper'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy coffee'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy tea'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo WHERE title = 'Buy beer'),
((SELECT id FROM event WHERE title = 'Conference'), SELECT id FROM todo WHERE title = 'Buy wine'),
((SELECT id FROM event WHERE title = 'Meeting'), SELECT id FROM todo