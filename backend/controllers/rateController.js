const Rate = require('../models/Rate');

// ✅ Update rate with specific date (or today's if not given)
exports.updateRates = async (req, res) => {
  try {
    const { gold24k, gold22k, gold20k, gold18k, silver, date } = req.body;

    // Use YYYY-MM-DD format for the date (consistent format)
    const selectedDate = date || new Date().toISOString().split('T')[0];

    let rate = await Rate.findOne({ date: selectedDate });

    if (!rate) {
      rate = new Rate({ date: selectedDate, gold24k, gold22k, gold20k, gold18k, silver });
    } else {
      rate.gold24k = gold24k;
      rate.gold22k = gold22k;
      rate.gold20k = gold20k;
      rate.gold18k = gold18k;
      rate.silver = silver;
    }

    await rate.save();
    res.status(200).json({ success: true, rate });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// ✅ Get today's rate (date format must match)
exports.getRates = async (req, res) => {
  try {
    const today = new Date().toISOString().split('T')[0]; // Ensure date is in YYYY-MM-DD format
    const rate = await Rate.findOne({ date: today });

    if (!rate) {
      return res.status(404).json({ success: false, message: "Rates not available for today." });
    }

    res.status(200).json({ success: true, rate });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
