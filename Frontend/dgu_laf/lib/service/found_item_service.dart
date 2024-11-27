import 'dart:convert';
import 'package:dgu_laf/model/found_item.dart';
import 'package:http/http.dart' as http;

class FoundItemService {
  static const String baseUrl = 'http://192.168.219.105:8080/found-items';

  // CREATE
  static Future<FoundItem> createFoundItem(FoundItem foundItem) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(foundItem.toJson()),
    );

    if (response.statusCode == 200) {
      return FoundItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create found item');
    }
  }

  // READ
  static Future<FoundItem> getFoundItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return FoundItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load found item');
    }
  }

  // UPDATE
  static Future<FoundItem> updateFoundItem(int id, FoundItem foundItem) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(foundItem.toJson()),
    );

    if (response.statusCode == 200) {
      return FoundItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update found item');
    }
  }

  // DELETE
  static Future<void> deleteFoundItem(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete found item');
    }
  }
}
