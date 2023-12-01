const db = require('../config/mysql.config');

let event_id
let cout_num_max = 4;


// srarの数が多い順にnum個取得 event_idとcount
exports.star_num_top = function (num, res) {
    db.query("SELECT event_id, count FROM star ORDER BY count DESC LIMIT ?;",[num], (err, results) => {
        if (err) throw err;
        console.log('star_num_top');
        console.log(results);
        console.log(results[0].event_id);
        
        return results;

    })

};

// event_idからeventの情報を取得できる（reqはevent_id）)
exports.event = function(req,res){
    db.query("SELECT description,people FROM event WHERE id = ? ;",[req],(err,results)=>{
        if(err)throw err;
        console.log('event_select');
        console.log(results);
        return results;

    })
}