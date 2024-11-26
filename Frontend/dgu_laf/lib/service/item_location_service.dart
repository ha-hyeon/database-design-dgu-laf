import 'dart:convert';
import 'package:dgu_laf/model/item_location.dart';
import 'package:http/http.dart' as http;

class ItemLocationService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<ItemLocation> addLocation(ItemLocation location) async {
    final response = await http.post(
      Uri.parse('$baseUrl/locations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(location.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemLocation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add location: ${response.statusCode}');
    }
  }

  static Future<ItemLocation> getLocationById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/locations/$id'));

    if (response.statusCode == 200) {
      return ItemLocation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch location: ${response.statusCode}');
    }
  }
}
