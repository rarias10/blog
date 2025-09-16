const express = require('express');
const app = express();
const { randomBytes } = require('crypto');
const bodyParser = require('body-parser');
const cors = require('cors');
const { default: axios } = require('axios');
const port = 4000;  

app.use(bodyParser.json());

app.use(cors());

const posts= {}

app.get('/posts', (req, res) => {
    res.send(posts);
});

app.post('/posts', async (req, res) => {
    const id = randomBytes(4).toString('hex');

    const { title } = req.body;

    posts[id] = { id, title };

    await axios.post('http://event-bus-srv:4005/events', {
        type: 'PostCreated',
        data: { id, title } 
    }).catch((err) => {
        console.log(err.message);
    });

    res.status(201).send(posts[id]);

});

app.post('/events', (req, res) => {
    console.log('Received Event', req.body.type);       
    res.send({});
});


app.listen(port, () => {
  console.log(`Posts service listening on port ${port}`);   
}); 