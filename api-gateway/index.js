const express = require('express');
const app = express();
const PORT = 3000;


// Route principale : vérifie que le gateway est vivant
app.get('/', (req, res) => {
  res.json({
    service: 'api-gateway',
    status: 'running',
    routes: ['/users', '/posts', '/media', '/notifications']
  });
});


// Redirige vers le user-service
// Dans Swarm, on utilise le NOM du service comme hostname
app.get('/users', async (req, res) => {
  try {
    const response = await fetch('http://user-service:3001/users');
    const data = await response.json();
    res.json(data);
  } catch (err) {
    res.status(503).json({ error: 'user-service indisponible', details: err.message });
  }
});


// Redirige vers le post-service
app.get('/posts', async (req, res) => {
  try {
    const response = await fetch('http://post-service:3002/posts');
    const data = await response.json();
    res.json(data);
  } catch (err) {
    res.status(503).json({ error: 'post-service indisponible', details: err.message });
  }
});


// Redirige vers le media-service
app.get('/media', async (req, res) => {
  try {
    const response = await fetch('http://media-service:3003/media');
    const data = await response.json();
    res.json(data);
  } catch (err) {
    res.status(503).json({ error: 'media-service indisponible', details: err.message });
  }
});


// Redirige vers le notification-service
app.get('/notifications', async (req, res) => {
  try {
    const response = await fetch('http://notification-service:3004/notifications');
    const data = await response.json();
    res.json(data);
  } catch (err) {
    res.status(503).json({ error: 'notification-service indisponible', details: err.message });
  }
});


app.listen(PORT, () => {
  console.log(`API Gateway running on port ${PORT}`);
});
