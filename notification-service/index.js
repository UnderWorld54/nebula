const express = require('express');
const os = require('os');
const app = express();
const PORT = 3004;


app.get('/notifications', (req, res) => {
  res.json({
    service: 'notification-service',
    hostname: os.hostname(),
    notifications: [
      { id: 1, type: 'new_follower', message: 'alice vous suit', read: false },
      { id: 2, type: 'new_post', message: 'bob a publié un nouveau post', read: false },
    ]
  });
});


app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'notification-service' });
});


app.listen(PORT, () => {
  console.log(`Notification Service running on port ${PORT}`);
});
