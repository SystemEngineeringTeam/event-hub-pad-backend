const  select = require('./select');

let star_top = [];
exports.top_star = function (num, res) {
    console.log('top_star');
    console.log(num);

    star_top.push(select.star_num_top(num, res));

    console.log('star_top');
    console.log(star_top);
    for (let i = 0; i < num; i++) {
        event_id = star_top[i].event_id;
        let event = select.event(event_id, res);

        star_top_json =  {
            "event_id": event_id,
            "description": event.description,
            "star": star_top[i].count,
            "people": event.people,
        };
        console.log(star_top_json);
    }

}