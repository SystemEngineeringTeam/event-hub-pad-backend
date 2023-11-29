const db = require('../config/mysql.config');

db.query('SELECT * FROM star LIMIT 4 ORDER BY count ;', (err, results) => {
    if (err) throw err;
    console.log(results);
});