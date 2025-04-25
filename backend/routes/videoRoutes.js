const express = require('express');
const router = express.Router();
const videoController = require('../controllers/videoController');

router.post('/upload', videoController.uploadVideo);
router.get('/get', videoController.getVideo);

module.exports = router;
