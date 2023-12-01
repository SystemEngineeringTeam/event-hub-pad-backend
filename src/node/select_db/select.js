const db = require('../config/mysql.config');
const util = require('util');

const query = util.promisify(db.query).bind(db); // bind(db) を追加

// event_idからeventの情報を取得できる（reqはevent_id）)
exports.star_num_top = async function (num) {

    try {
        console.log('test');
        const results = await query(`
    SELECT
        star.event_id,
        event.description,
        event.people,
        event.spend_time,
        COUNT(star.event_id) AS count,
        concat('[', group_concat(distinct event_tag.tag_id),']') AS tag_ids,
        concat('[', group_concat(distinct tag.word),']') AS words
    FROM event
    INNER JOIN star ON star.event_id = event.id
    INNER JOIN event_tag ON star.event_id = event_tag.event_id
    INNER JOIN tag ON event_tag.tag_id = tag.id
    GROUP BY star.event_id, event.description, event.people, event.spend_time
    ORDER BY COUNT(star.event_id) DESC
    LIMIT ?;
`, [num]);

        return results;
    } catch (err) {
        throw err;
    }
};

exports.other_events = async function (event) {
    
        try {
            // await query(` DELETE FROM event
            // WHERE event.id IN (SELECT star.event_id FROM star WHERE star.event_id = event.id);`);
            const results = await query(`
           
            
            SELECT
                star.event_id,
                event.description,
                event.people,
                event.spend_time,
                COUNT(star.event_id) AS count,
                CONCAT('[', GROUP_CONCAT(DISTINCT event_tag.tag_id), ']') AS tag_ids,
                CONCAT('[', GROUP_CONCAT(DISTINCT tag.word), ']') AS words
            FROM event
            INNER JOIN star ON star.event_id = event.id
            INNER JOIN event_tag ON star.event_id = event_tag.event_id
            INNER JOIN tag ON event_tag.tag_id = tag.id
            WHERE event.id NOT IN (?)
            GROUP BY star.event_id, event.description, event.people, event.spend_time
            ORDER BY event.id DESC;
    `, [event]);
    
            return results;
        } catch (err) {
            throw err;
        }
}

exports.event_detail = async function (eventid) {
    
        try {
            const results = await query(`
            SELECT
            event.title,
            event.description,
            event.people,
            event.spend_time,
            event.created_at,
            event.event_date,
            JSON_ARRAYAGG(JSON_OBJECT('id', todo.id, 'description', todo.description)) AS todos,
            JSON_ARRAYAGG(JSON_OBJECT('name', tool.name, 'amount', tool.que)) AS tools
          FROM
            event
          INNER JOIN
            event_todo_rlation ON event.id = event_todo_rlation.event_id
          INNER JOIN
            todo ON event_todo_rlation.todo_id = todo.id
          INNER JOIN
            event_tool_rlation ON event.id = event_tool_rlation.event_id
          INNER JOIN
            tool ON event_tool_rlation.tool_id = tool.id
          WHERE
            event.id = ?;
    `, [eventid]);
            console.log(results);
    
            return results;
        } catch (err) {
            throw err;
        }
    }


// event_idからeventの情報を取得できる（reqはevent_id）)
// exports.event = async function (req) {
//     try {
//         console.log(req);
//         console.log('event_select');
//         const results = await query(`
//         SELECT event.id, event.description, event.people, event.spend_time, event_tag.tag_id, star.count
//         FROM star
//         INNER JOIN event_tag ON star.event_id = event_tag.event_id
//         INNER JOIN event ON event.id = event_tag.event_id
//         ORDER BY count DESC LIMIT ? ;`, [req]);

//         console.log('event!!!!');
//         console.log(results);
//         return results;

//     } catch (err) {
//         throw err;
//     }
// }

// // event_idからtag_idの情報を取得できる（reqはevent_id）)
// exports.tag_id = async function (req) {

//     try {
//         console.log('tag_id');
//         const results = await query("SELECT tag_id FROM event_tag.event_tag ORDER BY count DESC LIMIT ? ;", [req]);
//         console.log(results);
//         return results;

//     } catch (err) {
//         throw err;
//     }

// }

// // tag_idからtagの情報を取得できる（reqはtag_id）)
// exports.tag = async function (req) {

//     try {
//         console.log('tag');
//         const results = await query("SELECT word FROM tag WHERE id IN (?) ;", [req]);
//         console.log(results);
//         return results;

//     } catch (err) {
//         throw err;
//     }

// }