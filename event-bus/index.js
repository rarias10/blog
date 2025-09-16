const express = require('express');
const app = express();
const port = 4005;  
const bodyParser = require('body-parser');
const cors = require('cors');
const axios = require('axios');
const e = require('express');

app.use(bodyParser.json());
app.use(cors());

const events = [];

app.get('/events', (req, res) => {
  res.send(events);
});

app.post('/events', async (req, res) => {
  const event = req.body;
  events.push(event);

  // Forward the event to all services
  try {
    await axios.post('http://posts-srv:4000/events', event);
  } catch (err) {}
  
  try {
    await axios.post('http://comments-srv:4001/events', event);
  } catch (err) {}
  
  try {
    await axios.post('http://query-srv:4002/events', event);
  } catch (err) {}

  try {
    await axios.post('http://moderation-srv:4003/events', event);
  } catch (err) {}

  res.send({ status: 'OK' });
});


app.listen(port, () => {
  console.log(`Event-bus service listening on port ${port}`);
});