const express = require('express');
const app = express();
const port = 8000;
const cors = require('cors');
const make_json = require('./select_db/make_json');
const bodyParser = require('body-parser');

app.use(cors());
app.use(express.json());


console.log('hello');


app.get('/', (req, res) => {
    res.send('Hello World!')
}
);  

app.get('/api/evens', (req, res) => {
    let num = Number(req.query.num);//クエリパラメーターの取得num
    make_json.top_event(num, res);

});
app.get('/api/evens/:eventid', (req, res) => {
    let event_id = Number(req.params.eventid);
    console.log(event_id);
    make_json.event_detail( event_id, res);
});

app.listen(port,()=>{
    console.log(`繋がったよhttp://localhost:${port}`)
}
);