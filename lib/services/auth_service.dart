// import '../models/user_model.dart';
// //import '../core/constants.dart';

// class AuthService {
//   static User createLocalUser(Map<String, dynamic> data) {
//     return User(
//       username: data["username"],
//       role: data["role"],
//       credits: data["credits"],
//     );
//   }
// }
import '../models/user_model.dart';

class AuthService {
  static User createLocalUser(Map<String, dynamic> response) {
    return User(
      username: response["username"] ?? "",
      role: response["role"] ?? "free",
      token: response["access_token"] ?? "",
      credits: response["role"] == "premium"
          ? 999
          : response["role"] == "admin"
          ? 9999
          : 5,
    );
  }
}
