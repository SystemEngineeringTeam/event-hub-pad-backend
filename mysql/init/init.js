// dbの初期化　クリエイト分かく
const db = require('../config/mysql.config.js');

const createTables = async () => {
        await connection.query(db.query(
            `CREATE TABLE IF NOT EXISTS user (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS event (
    id binary(16) NOT NULL,
    user_id int DEFAULT NULL,
    title varchar(50) DEFAULT NULL,
    description varchar(200) DEFAULT NULL,
    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    event_date date NOT NULL,
    people int NOT NULL,
    PRIMARY KEY (id)
  
);
CREATE TABLE IF NOT EXISTS event_tag (
    id int NOT NULL AUTO_INCREMENT,
  event_id binary(16) NOT NULL,
  tag_id int NOT NULL,
  PRIMARY KEY (id)

);
CREATE TABLE IF NOT EXISTS tag (
    id int NOT NULL AUTO_INCREMENT,
    word varchar(10) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS star (
    id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  event_id binary(16) NOT NULL,
  count int NOT NULL,
  PRIMARY KEY (id)
);
        `), (err, results) => {
            if (err) throw err;
            console.log(results);
        });
    };

