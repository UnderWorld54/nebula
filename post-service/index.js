const express = require('express');
const os = require('os');
const app = express();
const PORT = 3002;


const posts = [
  { id: 1, author: 'alice', content: 'Premier post sur Nebula !', hashtags: ['#nebula', '#debut'], timestamp: new Date().toISOString() },
  { id: 2, author: 'bob', content: 'Docker Swarm c\'est top', hashtags: ['#docker', '#swarm'], timestamp: new Date().toISOString() },
  { id: 3, author: 'charlie', content: 'Les microservices en action', hashtags: ['#microservices'], timestamp: new Date().toISOString() },
];


app.get('/posts', (req, res) => {
  res.json({
    service: 'post-service',
    hostname: os.hostname(),
    replica: process.env.HOSTNAME,
    posts: posts
  });
});


app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'post-service', hostname: os.hostname() });
});


app.listen(PORT, () => {
  console.log(`Post Service running on port ${PORT} - Container: ${os.hostname()}`);
});
