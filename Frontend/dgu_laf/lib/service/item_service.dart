import 'dart:convert';
import 'package:dgu_laf/model/item.dart';
import 'package:http/http.dart' as http;

// API URL 설정
const String baseUrl = 'http://192.168.219.103/dgulaf';

// 최근 아이템 목록을 가져오는 함수
Future<List<Item>> fetchRecentItems() async {
  final response =
      await http.get(Uri.parse('$baseUrl/items.php?action=recent'));

  if (response.statusCode == 200) {
    try {
      List<dynamic> data = json.decode(response.body);
      print(data); // 파싱된 데이터를 출력
      return data.map((itemJson) => Item.fromJson(itemJson)).toList();
    } catch (e) {
      throw Exception('Failed to decode JSON: $e');
    }
  } else {
    throw Exception(
        'Failed to load recent items. Status code: ${response.statusCode}');
  }
}

Future<Item> fetchItemDetails(int itemId) async {
  final response =
      await http.get(Uri.parse('$baseUrl/items.php?item_id=$itemId'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'error') {
      throw Exception(data['message']);
    }
    return Item.fromJson(data);
  } else {
    throw Exception('Failed to load item details');
  }
}
