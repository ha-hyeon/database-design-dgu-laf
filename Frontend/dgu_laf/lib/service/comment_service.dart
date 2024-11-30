import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  static const String baseUrl = 'http://192.168.219.105/dgulaf';

  /// 댓글 목록을 가져오는 함수
  static Future<List<Map<String, dynamic>>> fetchComments(int itemId) async {
    final url = Uri.parse('$baseUrl/comments.php?item_id=$itemId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // JSON 응답 파싱
        final List<dynamic> data = jsonDecode(response.body);
        // List<Map<String, dynamic>> 형식으로 반환
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<bool> deleteComment(int commentId, int commentUserId) async {
    final url = Uri.parse('$baseUrl/comments.php?comment_id=$commentId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['status'] == 'success';
    }

    return false;
  }

  static Future<bool> createComment({
    required int userId,
    required int itemId,
    required String content,
  }) async {
    final url = Uri.parse('$baseUrl/comments.php?action=create');
    final response = await http.post(
      url,
      body: {
        'user_id': userId.toString(),
        'item_id': itemId.toString(),
        'content': content,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['status'] == 'success';
    } else {
      return false;
    }
  }
}
