const insert = require('./insert');

exports.event_registration = async function (req,userid,res) {
   

    let event_post = insert.event_registration(req,user_id,res);

    event_post.then((result) => {
        console.log(result);
    }
    );
    res.json(event_post);




}

exports.star_registration = async function (req,userid,eventid,res) {
    let user_id = userid;
    let event_id = eventid;
    console.log(user_id);
    console.log(event_id);

    let star_post = insert.star_registration(user_id,event_id);

    res.json(star_post);
}