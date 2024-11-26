import 'dart:convert';
import 'package:dgu_laf/model/item_comment.dart';
import 'package:http/http.dart' as http;

class ItemCommentService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<ItemComment> addComment(ItemComment comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemComment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment: ${response.statusCode}');
    }
  }

  static Future<List<ItemComment>> getCommentsByItemId(
      int id, bool isLost) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/item/$id?isLost=$isLost'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ItemComment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch comments: ${response.statusCode}');
    }
  }
}
