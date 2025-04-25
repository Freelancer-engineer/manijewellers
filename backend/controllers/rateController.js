const Rate = require('../models/Rate');

exports.updateRates = async (req, res) => {
  try {
    const { gold24k, gold22k, gold20k, gold18k, silver } = req.body;
    const today = new Date().toLocaleDateString('en-GB');

    let rate = await Rate.findOne({ date: today });

    if (!rate) {
      rate = new Rate({ date: today, gold24k, gold22k, gold20k, gold18k, silver });
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

exports.getRates = async (req, res) => {
  try {
    const today = new Date().toLocaleDateString('en-GB');
    const rate = await Rate.findOne({ date: today });

    if (!rate) {
      return res.status(404).json({ success: false, message: "Rates not available for today." });
    }

    res.status(200).json({ success: true, rate });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
