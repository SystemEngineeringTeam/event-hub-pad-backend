const db = require('../config/mysql.config');
const util = require('util');

const query = util.promisify(db.query).bind(db); // bind(db) を追加

// srarの数が多い順にnum個取得 event_idとcount
exports.star_num_top = async function (num) {
    

    try {
        console.log('test');
        const results = await query("SELECT event_id, count FROM star ORDER BY count DESC LIMIT ?;", [num]);
        console.log('star_num_top');
        console.log(results);
        console.log(results[0].event_id);

        return results;
    } catch (err) {
        throw err;
    }
};


// event_idからeventの情報を取得できる（reqはevent_id）)
exports.event = async function(req){
    try{
        console.log('event_select');
        const results = await query("SELECT description,people FROM event WHERE id IN (?) ;",[req]);
        console.log(results);
        return results;

    }catch(err){
        throw err;
    }
}

// event_idからtag_idの情報を取得できる（reqはevent_id）)
exports.tag_id = async function(req){
    
        try{
            console.log('tag_id');
            const results = await query("SELECT tag_id FROM event_tag WHERE event_id IN (?) ;",[req]);
            console.log(results);
            return results;
    
        }catch(err){
            throw err;
        }
    
}

// tag_idからtagの情報を取得できる（reqはtag_id）)
exports.tag = async function(req){
    
        try{
            console.log('tag');
            const results = await query("SELECT word FROM tag WHERE id IN (?) ;",[req]);
            console.log(results);
            return results;
    
        }catch(err){
            throw err;
        }
    
}