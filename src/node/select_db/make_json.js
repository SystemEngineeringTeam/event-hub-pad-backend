const  select = require('./select');


exports.top_star = async function (num, res) {
    console.log('top_star');
    console.log(num);

    let star_top_json = [];


    let star_top = await select.star_num_top(num);

    console.log('star_top');
    console.log(star_top);



    for (let i = 0; i < num; i++) {
        event_id = star_top[i].event_id;
        let event = await select.event(event_id);

        star_top_json =  {
            "event_id": event_id,
            "description": event[0].description,
            "star": star_top[i].count,
            "people": event[0].people,
        };
        console.log('Jsonファイル');
        console.log(star_top_json);
    }

}