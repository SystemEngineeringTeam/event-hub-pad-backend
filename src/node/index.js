const express = require('express');
const app = express();
const port = 3000;
const cors = require('cors');
const pool = require('./config/mysql.config.js');
const bodyParser = require('body-parser');

app.use(cors());
app.use(express.json());


console.log('hello');





app.get('/', (req, res) => {
    res.send('Hello World!')
}
);  

app.get('/api/evens', (req, res) => {
    
});

app.listen(port,()=>{
    console.log(`繋がったよhttp://localhost:${port}`)
}
);