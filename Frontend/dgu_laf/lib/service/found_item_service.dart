import 'dart:convert';
import 'package:dgu_laf/model/found_item.dart';
import 'package:http/http.dart' as http;

class FoundItemService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<FoundItem> createFoundItem(FoundItem item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/found-items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return FoundItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create found item: ${response.statusCode}');
    }
  }

  static Future<FoundItem> getFoundItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/found-items/$id'));

    if (response.statusCode == 200) {
      return FoundItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch found item: ${response.statusCode}');
    }
  }
}
