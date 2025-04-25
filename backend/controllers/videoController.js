const Video = require('../models/Video');

exports.uploadVideo = async (req, res) => {
  try {
    const { videoUrl } = req.body;
    const video = new Video({ videoUrl });
    await video.save();
    res.status(201).json({ success: true, video });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getVideo = async (req, res) => {
  try {
    const video = await Video.findOne().sort({ uploadedAt: -1 });
    if (!video) {
      return res.status(404).json({ success: false, message: "No video uploaded yet." });
    }
    res.status(200).json({ success: true, video });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
