const db = require('../config/mysql.config.js');

app.post('/post/test', (req, res) => {

    const user_id = req.body.user_id;
    const event_id = req.body.event_id;
    const count = req.body.count;

    const sql = `INSERT INTO data (

        user_id,
        event_id,
        count
    )VALUES(
        ${user_id},
        ${event_id},
        ${count}
        )
        `;
    });
    db.query(sql, function (err, result) {
        if (err) {
            console.log(err);
            res.status(500).json({
                mesage: "err",
                err: err
            });
        } else {
            console.log(result);
            console.log("成功");
            res.status(200).json({
                mesage: "ok"
            });

        }
    });