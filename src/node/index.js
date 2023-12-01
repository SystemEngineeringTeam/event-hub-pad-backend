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
    console.log(num);
    console.log(typeof(num));
    console.log('アクセスされたよ');

    make_json.top_star(num,res);


});

app.listen(port,()=>{
    console.log(`繋がったよhttp://localhost:${port}`)
}
);