const express = require('express');
const router = express.Router();
const rateController = require('../controllers/rateController');

router.post('/update', rateController.updateRates);
router.get('/get', rateController.getRates);

module.exports = router;
