CREATE DATABASE IF NOT EXISTS eventhub_db;

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
CREATE TABLE `event_todo_relation` (
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
CREATE TABLE `event_tool_relation` (
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


-- sample data　　　UNHEX(REPLACE(UUID(), '-', ''))
-- Users


-- Insert test data for 'user' table
INSERT INTO `user` (`id`, `name`) VALUES
  (UNHEX(REPLACE(UUID(), '-', '')), 'Alice'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Bob'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Charlie'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'David'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Eve'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Frank'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Grace'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Henry'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Ivy'),
  (UNHEX(REPLACE(UUID(), '-', '')), 'Jack');

-- Insert test data for 'tag' table
INSERT INTO `tag` (`word`) VALUES
  ('Technology'), ('Science'), ('Art'), ('Music'), ('Travel'),
  ('Food'), ('Fitness'), ('Fashion'), ('Photography'), ('Sports');

-- Insert test data for 'event' table
INSERT INTO `event` (`user_id`, `title`, `description`, `event_date`, `people`, `spend_time`) VALUES
  ((SELECT id FROM user WHERE name = 'Alice'), 'Event1', 'Description1', '2023-01-01', 20, 3),
  ((SELECT id FROM user WHERE name = 'Bob'), 'Event2', 'Description2', '2023-02-01', 15, 2),
  ((SELECT id FROM user WHERE name = 'Charlie'), 'Event3', 'Description3', '2023-03-01', 25, 4),
  ((SELECT id FROM user WHERE name = 'David'), 'Event4', 'Description4', '2023-04-01', 10, 1),
  ((SELECT id FROM user WHERE name = 'Eve'), 'Event5', 'Description5', '2023-05-01', 30, 5),
  ((SELECT id FROM user WHERE name = 'Frank'), 'Event6', 'Description6', '2023-06-01', 12, 2),
  ((SELECT id FROM user WHERE name = 'Grace'), 'Event7', 'Description7', '2023-07-01', 18, 3),
  ((SELECT id FROM user WHERE name = 'Henry'), 'Event8', 'Description8', '2023-08-01', 22, 4),
  ((SELECT id FROM user WHERE name = 'Ivy'), 'Event9', 'Description9', '2023-09-01', 28, 5),
  ((SELECT id FROM user WHERE name = 'Jack'), 'Event10', 'Description10', '2023-10-01', 14, 2);

-- Insert test data for 'event_tag' table
INSERT INTO `event_tag` (`event_id`, `tag_id`) VALUES
  (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
  (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert test data for 'star' table
INSERT INTO `star` (`user_id`, `event_id`) VALUES
  ((SELECT id FROM user WHERE name = 'Alice'), 1),
  ((SELECT id FROM user WHERE name = 'Bob'), 2),
  ((SELECT id FROM user WHERE name = 'Charlie'), 3),
  ((SELECT id FROM user WHERE name = 'David'), 4),
  ((SELECT id FROM user WHERE name = 'Eve'), 5),
  ((SELECT id FROM user WHERE name = 'Frank'), 6),
  ((SELECT id FROM user WHERE name = 'Grace'), 7),
  ((SELECT id FROM user WHERE name = 'Henry'), 8),
  ((SELECT id FROM user WHERE name = 'Ivy'), 9),
  ((SELECT id FROM user WHERE name = 'Jack'), 10);

-- Insert test data for 'todo' table
INSERT INTO `todo` (`title`, `deadline`) VALUES
  ('Todo1', '2023-01-15'),
  ('Todo2', '2023-02-15'),
  ('Todo3', '2023-03-15'),
  ('Todo4', '2023-04-15'),
  ('Todo5', '2023-05-15'),
  ('Todo6', '2023-06-15'),
  ('Todo7', '2023-07-15'),
  ('Todo8', '2023-08-15'),
  ('Todo9', '2023-09-15'),
  ('Todo10', '2023-10-15');

-- Insert test data for 'event_todo_relation' table
INSERT INTO `event_todo_relation` (`event_id`, `todo_id`) VALUES
  (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
  (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert test data for 'tool' table
INSERT INTO `tool` (`name`, `qua`) VALUES
  ('Tool1', 5),
  ('Tool2', 3),
  ('Tool3', 8),
  ('Tool4', 2),
  ('Tool5', 10),
  ('Tool6', 6),
  ('Tool7', 4),
  ('Tool8', 7),
  ('Tool9', 1),
  ('Tool10', 9);

-- Insert test data for 'event_tool_relation' table
INSERT INTO `event_tool_relation` (`event_id`, `tool_id`) VALUES
  (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
  (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert test data for 'progress_todo' table
INSERT INTO `progress_todo` (`event_id`, `todo_id`) VALUES
  (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
  (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
