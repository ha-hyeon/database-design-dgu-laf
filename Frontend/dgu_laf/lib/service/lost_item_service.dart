import 'dart:convert';
import 'package:dgu_laf/model/lost_item.dart';
import 'package:http/http.dart' as http;

class LostItemService {
  static const String baseUrl = 'http://192.168.219.105:8080/lost-items';

  // CREATE
  static Future<LostItem> createLostItem(LostItem lostItem) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(lostItem.toJson()),
    );

    if (response.statusCode == 200) {
      return LostItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create lost item');
    }
  }

  // READ
  static Future<LostItem> getLostItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return LostItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load lost item');
    }
  }

  // UPDATE
  static Future<LostItem> updateLostItem(int id, LostItem lostItem) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(lostItem.toJson()),
    );

    if (response.statusCode == 200) {
      return LostItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update lost item');
    }
  }

  // DELETE
  static Future<void> deleteLostItem(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete lost item');
    }
  }
}
