import 'dart:convert';
import 'package:dgu_laf/model/item_image.dart';
import 'package:http/http.dart' as http;

class ItemImageService {
  static const String baseUrl = 'http://192.168.219.105:8080';

  static Future<ItemImage> addImage(ItemImage image) async {
    final response = await http.post(
      Uri.parse('$baseUrl/images'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(image.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemImage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add image: ${response.statusCode}');
    }
  }

  static Future<List<ItemImage>> getImagesByItemId(
      int itemId, bool isLost) async {
    final response = await http.get(
      Uri.parse('$baseUrl/images/$itemId?isLost=$isLost'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ItemImage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch images: ${response.statusCode}');
    }
  }
}
