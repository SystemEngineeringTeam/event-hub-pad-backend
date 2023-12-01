const  select = require('./select');


exports.top_star = async function (num, res) {

    // starの数が多い順にnum個取得 event_idとcount
    let star_top = await select.star_num_top(num);

    let event_id = [];
    for(let i = 0; i < num; i++){
         event_id.push(star_top[i].event_id);

    }
    // event_idからeventの情報を取得できる（reqはevent_id）)
   let event = await select.event(event_id)
    // event_idからtag_idの情報を取得できる（reqはevent_id）)
    let tag_id = await select.tag_id(event_id);
    console.log('tag_id');
    console.log(tag_id);

    let tag = [];
    for(let i = 0; i < num; i++){
       tag.push(tag_id[i].tag_id);
    }
    
    let star_top_json = [];

    for(let i = 0; i < num; i++){
        star_top_json.push({
            "event_id": event_id[i],
            "description": event[i].description,
            "star": star_top[i].count,
            "people": event[i].people,
        });
    }
    console.log('Jsonファイル');
    console.log(star_top_json);
        

   
    // for (let i = 0; i < num; i++) {
    //     event_id = star_top[i].event_id;
    //     let event = await select.event(event_id);

    //     star_top_json =  {
    //         "event_id": event_id,
    //         "description": event[0].description,
    //         "star": star_top[i].count,
    //         "people": event[0].people,
    //     };
    //     console.log('Jsonファイル');
    //     console.log(star_top_json);
    // }

}