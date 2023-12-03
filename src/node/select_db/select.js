const db = require("../config/mysql.config");
const util = require("util");

const query = util.promisify(db.query).bind(db); // bind(db) を追加

// event_idからeventの情報を取得できる（reqはevent_id）)
exports.star_num_top = async function (num) {
  try {
    const results = await query(
    `
    SELECT
    event.id,
    event.description,
    event.price,
    event.people,
    event.spend_time AS spentTime,
    IFNULL (tmp_star.count, 0) AS star,
    tmp_tag.tags
FROM
    event
    LEFT JOIN (
        SELECT
            event_id,
            COUNT(*) AS count
        FROM
            star
        GROUP BY
            event_id
    ) AS tmp_star ON event.id = tmp_star.event_id
    LEFT JOIN (
        SELECT
            et.event_id AS event_id,
            JSON_ARRAYAGG(
                JSON_OBJECT('id', t.id, 'name', t.word)
            ) AS tags
        FROM
            event_tag et
        INNER JOIN tag t ON et.tag_id = t.id
        GROUP BY et.event_id
    ) AS tmp_tag ON event.id = tmp_tag.event_id
    ORDER BY star DESC;

    `,
      // Specify the LIMIT value here
      [num]
    );

    return results;
  } catch (err) {
    throw err;
  }
};

exports.other_events = async function (event) {
  try {
    // await query(` DELETE FROM event
    // WHERE event.id IN (SELECT star.event_id FROM star WHERE star.event_id = event.id);`);
    const results = await query(
      `
           
            
            SELECT
                star.event_id,
                event.title,
                event.price,
                event.description,
                event.people,
                event.spend_time,
                event.event_date,
                COUNT(star.event_id) AS star,
                JSON_ARRAYAGG(JSON_OBJECT('id', tag.id, 'word', tag.word)) AS tags
            FROM event
            INNER JOIN star ON star.event_id = event.id
            INNER JOIN event_tag ON event_tag.event_id = event.id
            INNER JOIN tag ON event_tag.tag_id = tag.id
            WHERE event.id NOT IN (?)
            GROUP BY star.event_id, event.description, event.people, event.spend_time
            ORDER BY event.id DESC;
    `,
      [event]
    );

    return results;
  } catch (err) {
    throw err;
  }
};

exports.event_detail = async function (eventid) {
  try {
    const results = await query(
      `
            SELECT
            event.title,
            event.description,
            event.price,
            event.,
            event.people,
            event.spend_time,
            event.created_at,
            event.event_date,
            JSON_ARRAYAGG(JSON_OBJECT('id', todo.id, 'title', todo.title)) AS todos,
            JSON_ARRAYAGG(JSON_OBJECT('name', tool.name, 'amount', tool.qua)) AS tools
          FROM
            event
          INNER JOIN
            event_todo_relation ON event.id = event_todo_relation.event_id
          INNER JOIN
            todo ON event_todo_relation.todo_id = todo.id
          INNER JOIN
            event_tool_relation ON event.id = event_tool_relation.event_id
          INNER JOIN
            tool ON event_tool_relation.tool_id = tool.id
          WHERE
            event.id = ?;
    `,
      [eventid]
    );

    return results;
  } catch (err) {
    throw err;
  }
};

exports.todoAll = async function (userid) {
  try {
    const results = await query(
      `
      SELECT
         event.id AS id,
          event.title AS title,
          JSON_ARRAYAGG(JSON_OBJECT('id', todo.id, 'title', todo.title)) AS todos
      FROM progress_event
      INNER JOIN progress_todo ON progress_event.id = progress_todo.progress_event_id
      INNER JOIN event ON progress_event.event_id = event.id
      INNER JOIN todo ON progress_todo.todo_id = todo.id
      WHERE progress_event.user_id = UUID_TO_BIN(?)
      GROUP BY progress_event.event_id, event.title;
      `,
      [userid]
  );

    console.log("todo_list");
    console.log(results);

    return results;
  } catch (err) {
    throw err;
  }
};

exports.individual_todo_list = async function (userid, num) {
  try {
    const results = await query(
      `
      SELECT
      event.id AS id,
      event.title AS event,
       todo.title AS title
    FROM event
    INNER JOIN progress_event ON progress_event.id = event.id
    INNER JOIN progress_todo ON progress_event.id = progress_todo.progress_event_id
    INNER JOIN todo ON progress_todo.todo_id = todo.id
    WHERE progress_event.user_id = UUID_TO_BIN(?)
    ORDER BY todo.deadline DESC
    LIMIT ?;
            `,
      [userid, num]
    );

    console.log("individual_todo_list");
    console.log(results);

    return results;
  } catch (err) {
    // { "error" : ${err} }
    return err;
  }
};

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
