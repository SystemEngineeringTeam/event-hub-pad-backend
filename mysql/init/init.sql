CREATE DATABASE IF NOT EXISTS eventhub_db;

use  eventhub_db;
CREATE TABLE `event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` binary(16) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `event_date` date NOT NULL,
  `people` int NOT NULL,
  `price`  int NOT NULL,
  `spend_time` int NOT NULL,
  `others` varchar(200),
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
  `word` varchar(1000) NOT NULL,
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
  `name` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `todo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL,
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
  `name` varchar(1000) NOT NULL,
  `qua` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `event_tool_relation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `tool_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `progress_event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` binary(16) NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `progress_todo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `progress_event_id` int NOT NULL,
  `todo_id` int NOT NULL,
  `bool` boolean NOT NULL,
  PRIMARY KEY (`id`)
);


-- sample data　　　UNHEX(REPLACE(UUID(), '-', ''))
-- Users


-- Insert test data for 'user' table
INSERT INTO `user` (`id`, `name`) VALUES
  (UNHEX(REPLACE('245207C0-90FF-11EE-96BD-95E35D93FC62', '-', '')), '佐藤 さとる'),
  (UNHEX(REPLACE('24522ED0-90FF-11EE-96BD-95E35D93FC62', '-', '')), '山田 邪馬'),
  (UNHEX(REPLACE('24522ED1-90FF-11EE-96BD-95E35D93FC62', '-', '')), '斉藤 彩都'),
  (UNHEX(REPLACE('24522ED2-90FF-11EE-96BD-95E35D93FC62', '-', '')), '安藤 杏土'),
  (UNHEX(REPLACE('24522ED3-90FF-11EE-96BD-95E35D93FC62', '-', '')), '金田 佳奈'),
  (UNHEX(REPLACE('24522ED4-90FF-11EE-96BD-95E35D93FC62', '-', '')), '近藤 紺人'),
  (UNHEX(REPLACE('24522ED5-90FF-11EE-96BD-95E35D93FC62', '-', '')), '鈴木 珠洲'),
  (UNHEX(REPLACE('24522ED6-90FF-11EE-96BD-95E35D93FC62', '-', '')), '遠藤 縁兎'),
  (UNHEX(REPLACE('24522ED7-90FF-11EE-96BD-95E35D93FC62', '-', '')), '松本 末萌'),
  (UNHEX(REPLACE('24522ED8-90FF-11EE-96BD-95E35D93FC62', '-', '')), '水谷 祐生');

-- Insert test data for 'tag' table
INSERT INTO `tag` (`word`) VALUES
  ('レク'),
  ('ゲーム'),
  ('BBQ'),
  ('キャンプ'),
  ('飲み会'),
  ('学祭'),
  ('旅行'),
  ('勉強会'),
  ('誕生日'),
  ('結婚式'),
  ('忘年会'),
  ('新年会'),
  ('新入生歓迎会'),
  ('ボーリング'),
  ('焼肉'),
  ('クリスマス'),
  ('デート'),
  ('合コン'),
  ('女子会'),
  ('男子会'),
  ('家族旅行'),
  ('社員旅行');

-- Insert test data for 'event' table
INSERT INTO `event` (`user_id`, `title`, `description`, `event_date`, `people`,`price`, `spend_time`, `others`) VALUES
  ((SELECT id FROM user WHERE name = '佐藤 さとる'), 'ダウト大富豪', '大富豪とダウトを組み合わせたトランプゲームです。少人数でも楽しめるように大富豪を改変しました。', '2005-01-05', 3, 200, 10, '人数によってルールを少し変えた。'),
  ((SELECT id FROM user WHERE name = '佐藤 さとる'), 'BBQ', '新入生と現部員の交流を目的として、大学内のテラスでBBQを行いました。', '2023-02-12', 40, 100000, 300, '片付けが大変だったので、時間を多めに取る必要がありそうです。'),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), '模擬店', '大学祭で模擬店を出店しました。唐揚げやたこ焼きを中心とした揚げ物に加えて、飲み物を販売しました。', '2023-03-01', 12, 150000, 6000, '韓国のサイダーがよく売れました。'),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), '新入生歓迎会', 'サークル勧誘を目的としたボーリング大会を行いました。', '2023-05-030', 32, 20000, 120,'ゲームごとに順番にメンバーを入れ替えました'),
  ((SELECT id FROM user WHERE name = '山田 邪馬'), '大学祭打ち上げ', ' 大学祭後に大学祭の模擬店でスタッフとして働いてくれた部員の子たちと焼肉を食べに行きました。', '2023-05-01', 40, 50000, 360, '名札を配ったのが良かったと思います。'),
  ((SELECT id FROM user WHERE name = '山田 邪馬'), 'クリスマス忘年新年会', '冬休み前最後の授業日にクリスマス会、忘年会、新年会を含めたレクリエーション大会を行いました。', '2023-06-01', 7, 5000, 30, '小規模でやったのが計画が楽で良かったです'),
  ((SELECT id FROM user WHERE name = '斉藤 彩都'), 'ビンゴ大会', '前期期末テストが終わり、夏休みが始まる前に「前期お疲れ様です！」ということでビンゴ大会を行いました。みんなが欲しがるような豪華景品を用意しました。', '2023-07-01', 100, 500000, 2400, '景品にお金を掛けすぎました');

-- Insert test data for 'event_tag' table
INSERT INTO `event_tag` (`event_id`, `tag_id`) VALUES
  (1, 1),
  (1, 2),
  (1, 5),
  (2, 3),
  (2, 4),
  (3, 6),
  (4, 13),
  (4, 14),
  (4, 15),
  (4, 5), 
  (5, 14),
  (5, 15),
  (5, 5),
  (6, 16),
  (6, 11),
  (6, 12),
  (7, 1),
  (7, 2),
  (7, 13);

-- Insert test data for 'star' table
INSERT INTO `star` (`user_id`, `event_id`) VALUES
  ((SELECT id FROM user WHERE name = '山田 邪馬'), 1),
  ((SELECT id FROM user WHERE name = '山田 邪馬'), 2),
  ((SELECT id FROM user WHERE name = '斉藤 彩都'), 1),
  ((SELECT id FROM user WHERE name = '斉藤 彩都'), 2),
  ((SELECT id FROM user WHERE name = '安藤 杏土'), 1),
  ((SELECT id FROM user WHERE name = '安藤 杏土'), 2),
  ((SELECT id FROM user WHERE name = '金田 佳奈'), 1),
  ((SELECT id FROM user WHERE name = '金田 佳奈'), 2),
  ((SELECT id FROM user WHERE name = '近藤 紺人'), 1),
  ((SELECT id FROM user WHERE name = '近藤 紺人'), 2),
  ((SELECT id FROM user WHERE name = '鈴木 珠洲'), 1),
  ((SELECT id FROM user WHERE name = '鈴木 珠洲'), 2),
  ((SELECT id FROM user WHERE name = '遠藤 縁兎'), 1),
  ((SELECT id FROM user WHERE name = '遠藤 縁兎'), 2),
  ((SELECT id FROM user WHERE name = '松本 末萌'), 1),
  ((SELECT id FROM user WHERE name = '松本 末萌'), 2),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 1),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 2),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 2),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 3),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 7),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 8),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 9);

-- Insert test data for 'todo' table
INSERT INTO `todo` (`title`, `deadline`) VALUES
  ('トランプを買う', '2005-01-01'),
  ('人を集める', '2005-01-02'),
  ('場所の確保', '2005-01-03'),

  ('場所の借用書類の提出', '2023-02-01'),
  ('予算設定', '2023-02-02'),
  ('参加者の募集', '2023-02-03'),
  ('必要器具・食材の調達', '2023-02-10'),

  ('必要書類の提出', '2023-01-20'),
  ('検便の提出', '2023-02-01'),
  ('出店内容の決定', '2023-02-02'),
  ('スタッフの募集', '2023-02-02'),

  ('場所の確保', '2023-04-01'),
  ('宣伝方法の決定', '2023-05-1'),
  ('参加者の募集', '2023-05-14'),
  ('グループ作り', '2023-05-25');

-- Insert test data for 'event_todo_relation' table
INSERT INTO `event_todo_relation` (`event_id`, `todo_id`) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 4),
  (2, 5),
  (2, 6),
  (2, 7),
  (3, 8),
  (3, 9),
  (3, 10),
  (3, 11),
  (4, 12),
  (4, 13),
  (4, 14),
  (4, 15);

-- Insert test data for 'tool' table
INSERT INTO `tool` (`name`, `qua`) VALUES
  ('トランプ', '180'),
  ('机', '7'),
  ('椅子', '21'),
  ('飲み物', '21'),
  ('お菓子', '14'),
  ('ルール確認表', '7');

-- Insert test data for 'event_tool_relation' table
INSERT INTO `event_tool_relation` (`event_id`, `tool_id`) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (1, 5),
  (1, 6);

-- Insert test data for 'progress_event' table
INSERT INTO `progress_event` (`user_id`, `event_id`) VALUES
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 1),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 2),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 3),
  ((SELECT id FROM user WHERE name = '水谷 祐生'), 4);

-- Insert test data for 'progress_todo' table
INSERT INTO `progress_todo` (`progress_event_id`, `todo_id`, `bool`) VALUES
  (1, 1, 0),
  (1, 2, 0),
  (1, 3, 0),
  (2, 4, 0),
  (2, 5, 0),
  (2, 6, 0),
  (2, 7, 0),
  (3, 8, 0),
  (3, 9, 0),
  (3, 10, 0),
  (3, 11, 0),
  (4, 12, 0),
  (4, 13, 0),
  (4, 14, 0),
  (4, 15, 0);
