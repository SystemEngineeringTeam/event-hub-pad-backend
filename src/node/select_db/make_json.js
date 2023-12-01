const  select = require('./select');


exports.top_event = async function (num, res) {

   let event = await select.star_num_top(num);

    let event_id = [];
    for (let i = 0; i < event.length; i++) {
        event_id.push(event[i].event_id);
    }
    let other_events = await select.other_events(event_id);

    let event_json = [];
    event_json.push(event);
    event_json.push(other_events);

    res.json(event_json);

}

exports.event_detail = async function ( eventid, res) {
    res.json(await select.event_detail(eventid));
}