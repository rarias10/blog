const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const port = 4002;
const axios = require('axios');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const posts = {};

const handleEvent = (type, data) => {
  if (type === 'PostCreated') {
    const { id, title } = data;
    posts[id] = { id, title, comments: [] };
  }

  if (type === 'CommentCreated') {
    const { id, content, postId, status } = data;
    const post = posts[postId];
    post.comments.push({ id, content, status });
  }

  if (type === 'CommentUpdated') {
    const { id, content, postId, status } = data;
    const post = posts[postId];
    const comment = post.comments.find(comment => {
      return comment.id === id;
    });
    comment.status = status;
    comment.content = content;
  }
} 


app.get('/posts', async (req, res) => {
  res.send(posts);
});

app.post('/events', (req, res) => {
  const { type, data } = req.body; 
  
  handleEvent(type, data);

  res.send({});

});

app.listen(port, async () => {
  console.log(`Query service listening on port ${port}`);
  await axios.get('http://localhost:4005/events').then(res => {
    for (let event of res.data) {
      console.log('Processing event:', event.type);
      handleEvent(event.type, event.data);
    } 
  }).catch(err => {
    console.log(err.message);
  }); 
});