const db = require('../config/mysql.config');
const util = require('util');

const query = util.promisify(db.query).bind(db); // bind(db) を追加


exports.event_registration = async function (req,userid,res) {

    let user_id = userid;
    let title = req.body.title;
    let description = req.body.description;
    let others = req.body.others;
    let people = req.body.people;
    let spend_time = req.body.spentTime;
    let price = req.body.price;
    let event_date = req.body.implementationDate;

    let tool = req.body.preparation;

    let todo = req.body.todos;

    let tool_results = [];
    let todo_results = [];

    
    try {
        console.log('event_registration');
       let event_results = await query(`
        INSERT INTO event (user_id,title,description,event_date,people,price,spend_time,others)
        VALUES (UUID_TO_BIN(?),?,?,?,?,?,?,?);`, [user_id,title,description,event_date,people,price,spend_time,others]);
        
        let event_id = await query(`
        SELECT LAST_INSERT_ID();`);

        console.log("event_id!!!!");
        event_id =(event_id[0]['LAST_INSERT_ID()']);


            let tool_insert = tool.forEach(async (element) => {
            console.log('toolINSERT');
            console.log(element.title);
            console.log(element.description);
            await query(`
            INSERT INTO tool (name,qua)
            VALUES (?,?);`,
             [element.title,element.description]);
            
            let tool_id = await query(`
            SELECT LAST_INSERT_ID();`);
 
            tool_id =(tool_id[0]['LAST_INSERT_ID()']);

            let tool_relation = await query(`
            INSERT INTO event_tool_relation (event_id,tool_id)
            VALUES (?,?);`,[event_id,tool_id]);

            tool_results.push (tool_relation,tool_insert)
        });
        
         todo.forEach(async (element) => {
            console.log('todoINSERT');  
            console.log(element.title);
            console.log(element.deadline);
         let todo_insert = await query(`
            INSERT INTO todo (title,deadline)
            VALUES (?,?);`,
             [element.title,element.deadline]);
            
           let todo_id = await query(`
            SELECT LAST_INSERT_ID();`);

        console.log("todo_id!!!!");
        todo_id =(todo_id[0]['LAST_INSERT_ID()']);

            let todo_relation = await query(`
            INSERT INTO event_todo_relation (event_id,todo_id)
            VALUES (?,?);`,[event_id,todo_id]);

            todo_results.push(todo_relation, todo_insert);
        });

       results = {event_results,tool_results,todo_results};
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