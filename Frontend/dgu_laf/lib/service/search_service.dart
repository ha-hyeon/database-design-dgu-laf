import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  static const String baseUrl = 'http://localhost:8080';

  /// Search Lost Items
  static Future<List<dynamic>> searchLostItems(
      {String? keyword, int? classroomId}) async {
    final uri = Uri.parse('$baseUrl/search/lost-items').replace(
      queryParameters: {
        if (keyword != null) 'keyword': keyword,
        if (classroomId != null) 'classroomId': classroomId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search lost items: ${response.statusCode}');
    }
  }

  /// Search Found Items
  static Future<List<dynamic>> searchFoundItems(
      {String? keyword, int? classroomId}) async {
    final uri = Uri.parse('$baseUrl/search/found-items').replace(
      queryParameters: {
        if (keyword != null) 'keyword': keyword,
        if (classroomId != null) 'classroomId': classroomId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search found items: ${response.statusCode}');
    }
  }

  /// Unified Search for Lost and Found Items
  static Future<List<dynamic>> searchItems(
      {String? keyword, int? classroomId}) async {
    if (keyword == null || classroomId == null) {
      throw Exception(
          'Both keyword and classroomId are required for this search.');
    }

    final uri = Uri.parse('$baseUrl/search/items').replace(
      queryParameters: {
        'keyword': keyword,
        'classroomId': classroomId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search items: ${response.statusCode}');
    }
  }
}
