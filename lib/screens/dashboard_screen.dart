// import 'package:flutter/material.dart';
// import '../models/user_model.dart';
// import 'login_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   final User user;

//   const DashboardScreen({super.key, required this.user});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (_) => LoginScreen()),
//                 (route) => false,
//               );
//             },
//           ),
//         ],
//       ),

//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text("Welcome ${widget.user.username}"),
//             Text("Role: ${widget.user.role}"),
//             Text("Credits: ${widget.user.credits}"),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../core/api_service.dart';
import '../widgets/credit_widget.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  dynamic data;
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

  void fetchData() async {
    setState(() {
      loading = true;
    });

    final result = await ApiService.fetchPopulation(widget.user.role);

    setState(() {
      data = result;
      widget.user.credits--;
      loading = false;
    });
  }

  Color roleColor(String role) {
    if (role == "free") return Colors.grey;
    if (role == "premium") return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: FadeTransition(
        opacity: _fade,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👤 USER HEADER CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.lightGreen],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ${widget.user.username}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Role: ${widget.user.role}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: roleColor(widget.user.role),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // 💳 CREDIT WIDGET
              CreditWidget(credits: widget.user.credits),

              const SizedBox(height: 20),

              // 🚀 FETCH BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text("Fetch Population Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: fetchData,
                ),
              ),

              const SizedBox(height: 20),

              // 🔄 LOADING OR DATA
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : data != null
                  ? Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            data.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      "No data loaded yet",
                      style: TextStyle(color: Colors.grey),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
