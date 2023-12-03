const express = require('express');
const app = express();
const port = 8000;
const cors = require('cors');
const make_json = require('./select_db/make_json');
const post = require('./post/body_data');
const bodyParser = require('body-parser');

app.use(cors());

app.use(express.json());


console.log('hello');


app.get('/', (req, res) => {
    res.send('Hello World!')
}
);  

app.get('/api/events', (req, res) => {
    let num = Number(req.query.num);//クエリパラメーターの取得num
    make_json.top_event(num, res);

});
//  動かない
app.get('/api/events/detail/:eventid', (req, res) => {
    let event_id = Number(req.params.eventid);
    console.log(event_id);
    make_json.event_detail( event_id, res);
});

app.get('/api/:userid/todos/all', (req, res) => {
    let user_id = req.params.userid;
    console.log(user_id);
    make_json.todo_list(user_id, res);
});

// 常にたたかれるtodo
app.get('/api/:userid/todos', (req, res) => {
    let user_id = req.params.userid;
    let num = Number(req.query.num);
    console.log(user_id);
    console.log(num);
    make_json.individual_todo_list(user_id,num, res);
});

app.post('/api/:userid/events', (req, res) => {
    let user_id = req.params.userid;

    console.log(user_id);

    post.event_registration(req,user_id,res);

});

app.post('/api/:userid/star/:eventid', (req, res) => {
    let user_id = req.params.userid;
    let event_id = req.params.eventid;
    console.log(user_id);
    console.log(event_id);

    post.star_registration(req,user_id,event_id,res);

});

app.post('/api/user/:userid', (req, res) => {
    let user_id = req.params.userid;
    console.log(user_id);


    console.log("body");
    console.log(req.body.name);

    post.user_id(req,user_id,res);

});

app.delete('/api/:userid/star/:eventid', (req, res) => {
    let user_id = req.params.userid;
    console.log(user_id);
    let event_id = req.params.eventid; 
    post.star_erase(req,user_id,event_id,res);

});

app.listen(port,()=>{
    console.log(`繋がったよhttp://localhost:${port}`)
}
);