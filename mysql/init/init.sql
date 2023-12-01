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
  `count` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `user` (
  `id` binary(16) NOT NULL ,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

-- ここから追加
CREATE TABLE `todo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `deadline` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `event_todo_rlation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `todo_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `event_user_rlation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `tool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `qua` int NOT NULL,
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
((SELECT id FROM event WHERE title = 'Party'), 2),
((SELECT id FROM event WHERE title = 'Conference'), 3),
((SELECT id FROM event WHERE title = 'バーベーキュー'), 4),
((SELECT id FROM event WHERE title = 'aa'), 5),
((SELECT id FROM event WHERE title = 'fff'), 6),
((SELECT id FROM event WHERE title = 'ggg'), 7);

-- Stars
INSERT INTO `star` (user_id, event_id, count) VALUES
( (SELECT id FROM user WHERE name = 'John Doe'), (SELECT id FROM event WHERE title = 'Meeting'), 5),
( (SELECT id FROM user WHERE name = 'west'), (SELECT id FROM event WHERE title = 'Party'), 10),
( (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM event WHERE title = 'Conference'), 8),
( (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM event WHERE title = 'バーベーキュー'), 8),
( (SELECT id FROM user WHERE name = 'peter'), (SELECT id FROM event WHERE title = 'aa'), 8),
( (SELECT id FROM user WHERE name = 'Bella'), (SELECT id FROM event WHERE title = 'fff'), 8),
( (SELECT id FROM user WHERE name = 'alex'), (SELECT id FROM event WHERE title = 'ggg'), 8);


