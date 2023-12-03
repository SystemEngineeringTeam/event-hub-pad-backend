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

  let popularEvents = [];
  let otherEvents = [];
  let i = 0;
 
  event.forEach((element) => {
    if (i < num) {
      popularEvents.push(element);
    } else {
      otherEvents.push(element);
    }
    i++;
  });





  let event_json = {popularEvents, otherEvents};

  console.log(event_json);

  res.json(event_json);
};

// イベントの詳細を取得できる
exports.event_detail = async function (eventid, res) {
  let event_detail = await select.event_detail(eventid);
  // event_detail[0].event_date= formatDate(event_detail[0].event_date);

  console.log(event_detail[0].todos);
  console.log(event_detail[0].tools);

  event_detail[0].todos = JSON.parse(event_detail[0].todos);
  event_detail[0].tools = JSON.parse(event_detail[0].tools);

  let datelist = event_detail[0];
  console.log("datelist");
  console.log(datelist);
  res.json(datelist);
};

exports.todo_list = async function (userid, res) {
  let todoAll = await select.todoAll(userid);

  todoAll.forEach((element) => {
    element.todos = JSON.parse(element.todos);
  });

  let todoall = { todoAll };
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


