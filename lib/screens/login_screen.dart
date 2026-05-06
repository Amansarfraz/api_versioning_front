// import 'package:flutter/material.dart';
// import '../models/user_model.dart';
// //import '../services/auth_service.dart';
// import 'dashboard_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   String role = "free";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: const InputDecoration(labelText: "Username"),
//             ),

//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: "Password"),
//             ),

//             const SizedBox(height: 10),

//             DropdownButton<String>(
//               value: role,
//               isExpanded: true,
//               items: [
//                 "free",
//                 "premium",
//                 "admin",
//               ].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
//               onChanged: (val) {
//                 setState(() {
//                   role = val!;
//                 });
//               },
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () {
//                 int credits = role == "free"
//                     ? 5
//                     : role == "premium"
//                     ? 20
//                     : 999;

//                 User user = User(
//                   username: usernameController.text,
//                   role: role,
//                   credits: credits,
//                 );

//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => DashboardScreen(user: user),
//                   ),
//                 );
//               },
//               child: const Text("Login"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String role = "free";
  bool obscure = true;

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(
                      labelText: "Select Role",
                      prefixIcon: Icon(Icons.security),
                    ),
                    items: ["free", "premium", "admin"]
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        role = val!;
                      });
                    },
                  ),

                  const SizedBox(height: 25),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                        ),
                        onPressed: () {
                          final user = AuthService.login(
                            usernameController.text,
                            role,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DashboardScreen(user: user),
                            ),
                          );
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
