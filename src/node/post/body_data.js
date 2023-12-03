const insert = require('./insert');


exports.user_id = async function (req,userid,res) {
    let user_id = userid;
    console.log(user_id);
    console.log(req.body.name);

    let user = insert.user_id(req,user_id,res);

    res.json(user);
}

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

exports.star_erase = async function (userid,event_id,res) {
    let user_id = userid;
    console.log(user_id);

    let erase = insert.erase_star(user_id,event_id);

    res.json(erase);
}