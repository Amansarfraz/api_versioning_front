import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static String getVersion(String role) {
    if (role == "free") return "v1";
    if (role == "premium") return "v2";
    return "v3";
  }

  static Future<Map<String, dynamic>> fetchPopulation(String role) async {
    String version = getVersion(role);

    final url = Uri.parse("$baseUrl/$version/population");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
