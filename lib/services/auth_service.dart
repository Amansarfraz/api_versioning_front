// import '../models/user_model.dart';

// class AuthService {
//   static User createLocalUser(Map<String, dynamic> response) {
//     return User(
//       username: response["username"] ?? "",
//       role: response["role"] ?? "free",
//       token: response["access_token"] ?? "",
//       credits: response["role"] == "premium"
//           ? 999
//           : response["role"] == "admin"
//           ? 9999
//           : 5,
//     );
//   }
// }
import '../models/user_model.dart';

class AuthService {
  static User createLocalUser(Map<String, dynamic> response) {
    return User(
      username: response["username"] ?? "",
      role: response["role"] ?? "free",
      token: response["token"] ?? "",
      credits: response["role"] == "premium"
          ? 999
          : response["role"] == "admin"
          ? 9999
          : 5,
    );
  }
}
