import 'dart:convert';
import 'package:dgu_laf/model/lost_item.dart';
import 'package:http/http.dart' as http;

class LostItemService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<LostItem> createLostItem(LostItem item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lost-items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return LostItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create lost item: ${response.statusCode}');
    }
  }

  static Future<LostItem> getLostItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/lost-items/$id'));

    if (response.statusCode == 200) {
      return LostItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch lost item: ${response.statusCode}');
    }
  }
}
