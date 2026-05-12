// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../core/constants.dart';

// class ApiService {
//   static const String baseUrl = AppConstants.baseUrl;

//   // 🔐 REGISTER API
//   static Future<Map<String, dynamic>> register(
//     String username,
//     String password,
//     String role,
//   ) async {
//     final url = Uri.parse("$baseUrl/register");

//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "username": username,
//         "password": password,
//         "role": role,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Register Failed");
//     }
//   }

//   // 🔐 LOGIN API
//   static Future<Map<String, dynamic>> login(
//     String username,
//     String password,
//   ) async {
//     final url = Uri.parse("$baseUrl/login");

//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"username": username, "password": password}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Login Failed");
//     }
//   }

//   // 📊 POPULATION API
//   static Future<Map<String, dynamic>> fetchPopulation(String role) async {
//     String version = getVersion(role);

//     final url = Uri.parse("$baseUrl/$version/population");

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to load data");
//     }
//   }

//   static String getVersion(String role) {
//     if (role == "free") return "v1";
//     if (role == "premium") return "v2";
//     return "v3";
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;

  // 🔐 REGISTER API
  static Future<Map<String, dynamic>> register(
    String username,
    String password,
    String role,
  ) async {
    final url = Uri.parse("$baseUrl/register");

    print("=========== REGISTER API ===========");
    print("URL => $url");

    final bodyData = {"username": username, "password": password, "role": role};

    print("REQUEST BODY => ${jsonEncode(bodyData)}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyData),
    );

    print("STATUS CODE => ${response.statusCode}");
    print("RESPONSE BODY => ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Register Failed => ${response.statusCode} ${response.body}",
      );
    }
  }

  // 🔐 LOGIN API
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/login");

    print("=========== LOGIN API ===========");
    print("URL => $url");

    final bodyData = {"username": username, "password": password};

    print("REQUEST BODY => ${jsonEncode(bodyData)}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyData),
    );

    print("STATUS CODE => ${response.statusCode}");
    print("RESPONSE BODY => ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Login Failed => ${response.statusCode} ${response.body}",
      );
    }
  }

  // 📊 POPULATION API
  static Future<Map<String, dynamic>> fetchPopulation(String role) async {
    String version = getVersion(role);

    final url = Uri.parse("$baseUrl/$version/population");

    print("=========== POPULATION API ===========");
    print("URL => $url");

    final response = await http.get(url);

    print("STATUS CODE => ${response.statusCode}");
    print("RESPONSE BODY => ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data => ${response.statusCode}");
    }
  }

  static String getVersion(String role) {
    if (role == "free") return "v1";
    if (role == "premium") return "v2";
    return "v3";
  }
}
