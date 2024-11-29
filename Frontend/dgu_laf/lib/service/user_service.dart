import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://192.168.219.103/dgulaf';

class UserService {
  // 로그인 처리
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users.php?action=login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data['status'] == 'error') {
          throw Exception(data['message']);
        }
        return data;
      } catch (e) {
        throw Exception('Failed to parse response');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  // 회원가입 처리 - 정적 메서드로 변경
  static Future<Map<String, dynamic>> register(
      String username, String password, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users.php?action=register'),
      body: {
        'username': username,
        'password': password,
        'phone_number': phoneNumber,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}
