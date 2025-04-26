class AuthService {
  static const String _defaultUserId = 'admin';
  static const String _defaultPassword = 'password123';

  static bool authenticate(String userId, String password) {
    return userId == _defaultUserId && password == _defaultPassword;
  }
}

