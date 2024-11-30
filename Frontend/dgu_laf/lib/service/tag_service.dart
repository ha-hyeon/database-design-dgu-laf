import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TagService {
  final String baseUrl = "http://192.168.219.105/dgulaf"; // 서버 주소

  // 특정 tag_id에 해당하는 tag_name 조회
  Future<String?> getTagName(int tagId) async {
    final url = Uri.parse('$baseUrl/items.php?action=get_tag&tag_id=$tagId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          return data['tag_name']; // 조회 성공 시 tag_name 반환
        } else {
          print('Error: ${data['message']}');
          return null;
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching tag name: $e');
      return null;
    }
  }
}
