import 'dart:convert';
import 'package:dgu_laf/model/item_comment.dart';
import 'package:http/http.dart' as http;

class ItemCommentService {
  static const String baseUrl = 'http://localhost:8080/comments';

  // CREATE - 댓글 추가
  static Future<ItemComment> addComment(ItemComment comment) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemComment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add comment: ${response.statusCode}');
    }
  }

  // READ - 아이템별 댓글 조회
  static Future<List<ItemComment>> getCommentsByItemId(
      int id, bool isLost) async {
    final response = await http.get(
      Uri.parse('$baseUrl/item/$id?isLost=$isLost'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ItemComment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch comments: ${response.statusCode}');
    }
  }

  // UPDATE - 댓글 수정
  static Future<ItemComment> updateComment(int id, ItemComment comment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode == 200) {
      return ItemComment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update comment: ${response.statusCode}');
    }
  }

  // DELETE - 댓글 삭제
  static Future<void> deleteComment(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete comment: ${response.statusCode}');
    }
  }
}
