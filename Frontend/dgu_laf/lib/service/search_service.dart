import 'dart:convert';
import 'package:dgu_laf/model/found_item.dart';
import 'package:dgu_laf/model/lost_item.dart';
import 'package:http/http.dart' as http;

class SearchService {
  static const String baseUrl = 'http://192.168.219.105:8080';

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

  static Future<List<dynamic>> getRecentItems() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/search/recent-items'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) {
          if (e['is_lost'] == true) {
            return LostItem.fromJson(e);
          } else {
            return FoundItem.fromJson(e);
          }
        }).toList();
      } else {
        throw Exception('Failed to fetch recent items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching recent items');
    }
  }
}
