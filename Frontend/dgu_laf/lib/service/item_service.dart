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

Future<List<Item>> fetchFilteredItems({
  required String title,
  required int classroomId,
  required String itemType,
}) async {
  final url = Uri.parse(
      '$baseUrl/items.php?action=filter&title=$title&classroom_id=$classroomId&item_type=$itemType');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch filtered items');
  }
}

Future<Map<String, dynamic>> createItem({
  required String itemType,
  required String title,
  required String itemDate,
  required String description,
  required int classroomId,
  required String detailLocation,
}) async {
  final userId = 1; // 로그인된 사용자의 user_id를 가져오는 방법 필요

  final response = await http.post(
    Uri.parse('$baseUrl/items.php'),
    body: {
      'action': 'create',
      'user_id': userId.toString(),
      'item_type': itemType,
      'title': title,
      'item_date': itemDate,
      'description': description,
      'classroom_id': classroomId.toString(),
      'detail_location': detailLocation,
    },
  );

  return json.decode(response.body);
}
