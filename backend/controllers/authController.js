exports.login = async (req, res) => {
    try {
      const { username, password } = req.body;
  
      const defaultUsername = 'admin';
      const defaultPassword = 'admin123';
  
      if (username !== defaultUsername || password !== defaultPassword) {
        return res.status(401).json({ success: false, message: 'Invalid username or password' });
      }
  
      res.status(200).json({ success: true, message: 'Login successful' });
    } catch (err) {
      res.status(500).json({ success: false, message: err.message });
    }
  };
  