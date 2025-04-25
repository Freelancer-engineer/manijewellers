const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true } // Not hashed (for demo only)
});

module.exports = mongoose.model('User', userSchema);
