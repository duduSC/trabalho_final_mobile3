class Authentication{
  static final Map<String,String> _users = {};

  static bool authenticate(String user, String password){
    final pass = _users[user.trim()];
    return pass != null && pass == password;
  }

  static void registerUser(String user, String password) {
    _users[user.trim()] = password.trim();
  }

}