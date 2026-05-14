// import 'package:flutter/material.dart';
// import '../core/api_service.dart';
// import '../services/auth_service.dart';
// import 'dashboard_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   String role = "free";
//   bool loading = false;
//   bool obscure = true;

//   late AnimationController _controller;
//   late Animation<double> _fade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );

//     _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> loginUser() async {
//     setState(() => loading = true);

//     try {
//       final response = await ApiService.login(
//         usernameController.text,
//         passwordController.text,
//       );

//       final user = AuthService.createLocalUser(response);

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => DashboardScreen(user: user)),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Login Failed")));
//     }

//     setState(() => loading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       body: FadeTransition(
//         opacity: _fade,
//         child: Center(
//           child: Container(
//             margin: const EdgeInsets.all(20),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 20),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Welcome Back",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 TextField(
//                   controller: usernameController,
//                   decoration: const InputDecoration(
//                     labelText: "Username",
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 TextField(
//                   controller: passwordController,
//                   obscureText: obscure,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     prefixIcon: const Icon(Icons.lock),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         obscure ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.green,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           obscure = !obscure;
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 DropdownButtonFormField<String>(
//                   value: role,
//                   decoration: const InputDecoration(
//                     labelText: "Role",
//                     prefixIcon: Icon(Icons.security),
//                   ),
//                   items: ["free", "premium", "admin"]
//                       .map((r) => DropdownMenuItem(value: r, child: Text(r)))
//                       .toList(),
//                   onChanged: (val) {
//                     setState(() {
//                       role = val!;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 25),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: loading ? null : loginUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     child: loading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("LOGIN"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

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
  bool loading = false;
  bool obscure = true;

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    setState(() => loading = true);

    try {
      final response = await ApiService.login(
        usernameController.text,
        passwordController.text,
      );

      final user = AuthService.createLocalUser(response);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen(user: user)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Failed")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 22,
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
                      labelText: "Role",
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

                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loading ? null : loginUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("LOGIN"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // REGISTER BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.green),
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
