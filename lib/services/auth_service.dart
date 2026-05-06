import '../models/user_model.dart';

class AuthService {
  static User login(String username, String role) {
    int credits = 0;

    if (role == "free") credits = 5;
    if (role == "premium") credits = 20;
    if (role == "admin") credits = 999;

    return User(username: username, role: role, credits: credits);
  }
}
