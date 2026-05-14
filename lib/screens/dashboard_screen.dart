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

    try {
      final result = await ApiService.fetchPopulation(
        widget.user.role,
        widget.user.token,
      );

      setState(() {
        data = result;
        widget.user.credits--;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(e.toString())),
      );
    }
  }

  Color roleColor(String role) {
    if (role == "free") return Colors.grey;
    if (role == "premium") return Colors.green;
    return Colors.red;
  }

  IconData roleIcon(String role) {
    if (role == "free") return Icons.person;
    if (role == "premium") return Icons.workspace_premium;
    return Icons.admin_panel_settings;
  }

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Population Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP USER CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff11998E), Color(0xff38EF7D)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(
                        roleIcon(widget.user.role),
                        color: roleColor(widget.user.role),
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome ${widget.user.username}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              widget.user.role.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // CREDIT CARD
              CreditWidget(credits: widget.user.credits),

              const SizedBox(height: 25),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.cloud_download),
                  label: const Text(
                    "Fetch Population Data",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: loading ? null : fetchData,
                ),
              ),

              const SizedBox(height: 30),

              if (loading)
                const Center(child: CircularProgressIndicator())
              else if (data != null)
                Column(
                  children: [
                    infoCard(
                      icon: Icons.person,
                      title: "Username",
                      value: widget.user.username,
                      color: Colors.blue,
                    ),

                    infoCard(
                      icon: Icons.security,
                      title: "Role",
                      value: widget.user.role,
                      color: Colors.orange,
                    ),

                    infoCard(
                      icon: Icons.api,
                      title: "API Version",
                      value: ApiService.getVersion(widget.user.role),
                      color: Colors.purple,
                    ),

                    infoCard(
                      icon: Icons.credit_score,
                      title: "Remaining Credits",
                      value: widget.user.credits.toString(),
                      color: Colors.green,
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.bar_chart, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Population Data",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Version : ${data["version"]}"),
                              const SizedBox(height: 5),

                              Text("Access : ${data["access"]}"),
                              const SizedBox(height: 5),

                              Text("Country : ${data["country"]}"),
                              const SizedBox(height: 5),

                              Text("Population : ${data["population"]}"),
                              const SizedBox(height: 5),

                              Text("User : ${data["user"]}"),
                              const SizedBox(height: 15),

                              const Text(
                                "Provinces:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Growth Rate : ${data?["growth_rate"] ?? "-"}",
                              ),
                              const SizedBox(height: 5),

                              Text(
                                "Literacy Rate : ${data?["literacy_rate"] ?? "-"}",
                              ),

                              //const SizedBox(height: 10),
                              const SizedBox(height: 8),

                              ...(data["provinces"] as List).map((p) {
                                // agar list string ho
                                if (p is String) {
                                  return Text("• $p");
                                }

                                // agar object ho (v3 case)
                                return Text(
                                  "• ${p["name"]} → ${p["cities"].join(", ")}",
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 90,
                        color: Colors.green.shade300,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "No Data Loaded Yet",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Click the button above to fetch data",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
