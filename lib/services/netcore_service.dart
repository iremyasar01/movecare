import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movecare/constants/netcore_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetcoreService {
 static const _baseurl = NetcoreConstant.BASE_URL;
 static Future<http.Response> login(String emailOrUsername, String password, String passwordAgain) async {
    final url = Uri.parse("$_baseurl/api/Users/Login");

    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailOrUsername,
        'username': emailOrUsername,
        'password': password,
        'passwordAgain': passwordAgain,
      }),
    );
  }
  static Future<http.Response> register(
    String username,
    String email,
    String name,
    String surname,
    String phoneNumber,
    String password,
    String passwordAgain) async {
  final url = Uri.parse("$_baseurl/api/Users/Registration");

  return await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'email': email,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'password': password,
      'passwordAgain': passwordAgain,
    }),
  );
}
  
   Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) return {'error': 'User ID not found. Please log in.'};

    final url = Uri.parse('$_baseurl/api/Users/GetUser?id=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': 'Failed to load user data'};
    }
  }
  Future<Map<String, dynamic>?> updatePassword(String currentPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) return {'error': 'User ID not found. Please log in.'};

    final url = Uri.parse('$_baseurl/api/Users/UpdatePassword');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      return {'error': jsonDecode(response.body)['message'] ?? 'Failed to update password'};
    }
  }
}



