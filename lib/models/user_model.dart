// class User {
//   final String username;
//   final String role;
//   int credits;

//   User({required this.username, required this.role, required this.credits});
// }
class User {
  final String username;
  final String role;
  final String token;
  int credits;

  User({
    required this.username,
    required this.role,
    required this.token,
    required this.credits,
  });
}
