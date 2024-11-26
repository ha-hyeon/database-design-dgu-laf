import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<List<dynamic>> searchItems(
      String keyword, int? classroomId) async {
    final uri = Uri.parse('$baseUrl/search/items').replace(queryParameters: {
      'keyword': keyword,
      if (classroomId != null) 'classroomId': classroomId.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search items: ${response.statusCode}');
    }
  }
}
