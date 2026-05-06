// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen>
//     with SingleTickerProviderStateMixin {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   String role = "free";

//   late AnimationController _controller;
//   late Animation<double> _fade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Color roleColor() {
//     if (role == "free") return Colors.grey;
//     if (role == "premium") return Colors.green;
//     return Colors.red;
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
//                 BoxShadow(
//                   color: Colors.green.withOpacity(0.2),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // USERNAME
//                 TextField(
//                   controller: usernameController,
//                   decoration: const InputDecoration(
//                     labelText: "Username",
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // PASSWORD
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: "Password",
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // ROLE DROPDOWN
//                 DropdownButtonFormField<String>(
//                   value: role,
//                   decoration: const InputDecoration(
//                     labelText: "Select Role",
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

//                 // REGISTER BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginScreen()),
//                       );
//                     },
//                     child: const Text(
//                       "REGISTER",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Text(
//                   "Selected Role: $role",
//                   style: TextStyle(color: roleColor()),
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
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String role = "free";
  bool loading = false;

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
    super.dispose();
  }

  Future<void> registerUser() async {
    setState(() => loading = true);

    try {
      await ApiService.register(
        usernameController.text,
        passwordController.text,
        role,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registered Successfully")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration Failed")));
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
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 20),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Create Account",
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
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
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

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loading ? null : registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("REGISTER"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
