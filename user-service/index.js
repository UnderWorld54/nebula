const express = require('express');
const os = require('os');
const app = express();
const PORT = 3001;


// Données fictives
const users = [
  { id: 1, username: 'alice', displayName: 'Alice Martin', followers: 120 },
  { id: 2, username: 'bob', displayName: 'Bob Dupont', followers: 85 },
  { id: 3, username: 'charlie', displayName: 'Charlie Durand', followers: 340 },
];


app.get('/users', (req, res) => {
  res.json({
    service: 'user-service',
    hostname: os.hostname(),  // montre quel conteneur répond
    users: users
  });
});


app.get('/users/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id));
  if (!user) return res.status(404).json({ error: 'User not found' });
  res.json({ service: 'user-service', hostname: os.hostname(), user });
});


app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'user-service' });
});


app.listen(PORT, () => {
  console.log(`User Service running on port ${PORT}`);
});
