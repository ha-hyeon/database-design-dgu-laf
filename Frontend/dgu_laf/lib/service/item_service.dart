import 'dart:convert';
import 'package:dgu_laf/model/item.dart';
import 'package:http/http.dart' as http;

// API URL 설정
const String baseUrl = 'http://192.168.219.105/dgulaf';

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

// 사용자 ID를 받아서 해당 사용자가 작성한 아이템 목록을 가져오는 함수
Future<List<Item>> fetchMyItems(String userId) async {
  final url = Uri.parse('$baseUrl/items.php?action=my_items&user_id=$userId');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      List<dynamic> items = data['items'];
      return items.map((itemJson) => Item.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to load user items: ${data['message']}');
    }
  } else {
    throw Exception(
        'Failed to fetch user items. Status code: ${response.statusCode}');
  }
}

Future<Item> fetchItemDetails(int itemId) async {
  final response = await http
      .get(Uri.parse('$baseUrl/items.php?action=get_item&item_id=$itemId'));

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
  required int tagId,
  required String itemType,
}) async {
  final url = Uri.parse(
      '$baseUrl/items.php?action=filter&title=$title&classroom_id=$classroomId&tag_id=$tagId&item_type=$itemType');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // JSON 응답에서 바로 items 배열을 가져옵니다.
    final List<dynamic> items = data; // 데이터 전체가 배열일 경우 바로 할당
    return items.map((item) => Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch filtered items');
  }
}

Future<Map<String, dynamic>> createItem({
  required String userId,
  required String itemType,
  required String title,
  required String itemDate,
  required String description,
  required int classroomId,
  required int tagId,
  required String detailLocation,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/items.php'),
    body: {
      'action': 'create',
      'user_id': userId,
      'item_type': itemType,
      'title': title,
      'item_date': itemDate,
      'description': description,
      'classroom_id': classroomId.toString(),
      'tag_id': tagId.toString(),
      'detail_location': detailLocation,
    },
  );

  return json.decode(response.body);
}

// 아이템 수정
Future<Map<String, dynamic>> updateItem({
  required String userId,
  required int itemId,
  required String title,
  required String description,
}) async {
  final response = await http.put(
    Uri.parse('$baseUrl/items.php?action=update&item_id=$itemId'),
    body: {
      'title': title,
      'description': description,
    },
  );

  return json.decode(response.body);
}

// 아이템 삭제
Future<Map<String, dynamic>> deleteItem({
  required int itemId,
}) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/items.php?action=delete&item_id=$itemId'),
  );

  return json.decode(response.body);
}
