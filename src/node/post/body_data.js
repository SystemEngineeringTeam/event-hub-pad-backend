const insert = require('./insert');

exports.event_registration = async function (req,userid,res) {
   
    let user_id = userid;
    let title = req.body.title;
    let description = req.body.description;
    let event_date = req.body.event_date;
    let people = req.body.people;
    let spend_time = req.body.spend_time;

    console.log(user_id);
    console.log(title);
    console.log(description);
    console.log(event_date);
    console.log(people);
    console.log(spend_time);




    let event_post = insert.event_registration(req,user_id,res);
    
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