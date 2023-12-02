const db = require('../config/mysql.config');
const util = require('util');

const query = util.promisify(db.query).bind(db); // bind(db) を追加


exports.event_registration = async function (req,userid,res) {

    let user_id = userid;
    let title = req.body.title;
    let description = req.body.description;
    let event_date = req.body.event_date;
    let people = req.body.people;
    let spend_time = req.body.spend_time; 
    
    try {
        console.log('event_registration');
        const results = await query(`
        INSERT INTO event (user_id,title,description,event_date,people,spend_time)
        VALUES (UUID_TO_BIN(?),?,?,?,?,?);`, [user_id,title,description,event_date,people,spend_time]);
        console.log(results);

        return results;

    } catch (err) {
        throw err;
    }

}

exports.star_registration = async function (userid,eventid) {
    let user_id = userid;
    let event_id = eventid;
    console.log(user_id);
    console.log(event_id);


    try {

        const results = await query(`
        INSERT INTO star (user_id,event_id)
        VALUES (UUID_TO_BIN(?),?);`, [user_id,event_id]);

        return results;

    } catch (err) {
        throw err;
    }

}