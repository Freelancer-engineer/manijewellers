const mongoose = require('mongoose');

const rateSchema = new mongoose.Schema({
  date: { type: String, required: true },
  gold24k: { type: Number, required: true },
  gold22k: { type: Number, required: true },
  gold20k: { type: Number, required: true },
  gold18k: { type: Number, required: true },
  silver:  { type: Number, required: true }
});

module.exports = mongoose.model('Rate', rateSchema);
