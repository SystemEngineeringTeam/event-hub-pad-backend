const select = require("./select");

// 人気のイベントを取得できる 最初のページ
exports.top_event = async function (num, res) {
  let event = await select.star_num_top(num);


  event.sort(function (a, b) {
    if (a.star < b.star) {
      return 1;
    } else {
      return -1;
    }
  });

  event.forEach((element) => {
    element.tags = JSON.parse(element.tags);
  }
  );


  // let event_id = [];
  // for (let i = 0; i < event.length; i++) {
  //   event_id.push(event[i].event_id);
  // }
  // let other_events = await select.other_events(event_id);

  //   event.forEach((element) => {
  //   element.tags = JSON.parse(element.tags);
  //   });
  // other_events.forEach((element) => {
  //   element.tags = JSON.parse(element.tags);
  // }
  //   );


  // let event_json = [];
  // event_json.push(event);
  // event_json.push(other_events);

  console.log(event);

  res.json(event);
};

// イベントの詳細を取得できる
exports.event_detail = async function (eventid, res) {
  let event_detail = await select.event_detail(eventid);

  //     function formatDateToYYYYMMDD(date) {
  //         const year = date.getFullYear();
  //         const month = String(date.getMonth() + 1).padStart(2, '0');
  //         const day = String(date.getDate()).padStart(2, '0');
  //         return `${year}-${month}-${day}`;
  //       }

  //       // 使用例
  //     function formatDate (date) {
  //       const nodejsDate = new Date(date); // 任意の日付を指定する場合は引数に対象のDateオブジェクトを渡します
  //       const formattedDate = formatDateToYYYYMMDD(nodejsDate);

  //       console.log(formattedDate);
  //       return formattedDate;
  //     }

  //    event_detail[0].created_at= formatDate(event_detail[0].created_at);
  // event_detail[0].event_date= formatDate(event_detail[0].event_date);

  console.log(event_detail[0].todos);
  console.log(event_detail[0].tools);

  event_detail[0].todos = JSON.parse(event_detail[0].todos);
  event_detail[0].tools = JSON.parse(event_detail[0].tools);

  let datelist = event_detail[0];

  console.log(datelist);
  res.json(datelist);
};

exports.todo_list = async function (userid, res) {
  let todo_list = await select.todo_list(userid);

  todo_list.forEach((element) => {
    element.todos = JSON.parse(element.todos);
  });

  let todoall = { todo_list };
  console.log(todoall);
  res.json(todoall);
};

exports.individual_todo_list = async function (userid, num, res) {
  // console.log(userid, num);
  let todos = await select.individual_todo_list(userid, num);

    let todoall = { todos };

  console.log(todoall);
  res.json(todoall);
};
