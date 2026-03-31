const express = require('express');
const os = require('os');
const app = express();
const PORT = 3003;


app.get('/media', (req, res) => {
  res.json({
    service: 'media-service',
    hostname: os.hostname(),
    message: 'Media service is ready to handle uploads',
    supportedFormats: ['jpg', 'png', 'gif', 'webp']
  });
});


app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'media-service' });
});


app.listen(PORT, () => {
  console.log(`Media Service running on port ${PORT}`);
});
