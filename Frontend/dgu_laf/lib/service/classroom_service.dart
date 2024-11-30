import 'dart:convert';
import 'package:http/http.dart' as http;

class ClassroomService {
  final String baseUrl = "http://192.168.219.105/dgulaf"; // 서버 주소

  // 특정 classroom_id에 해당하는 building_name 조회
  Future<String?> getBuildingName(int classroomId) async {
    final url = Uri.parse(
        '$baseUrl/items.php?action=get_classroom&classroom_id=$classroomId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          return data['building_name']; // 조회 성공 시 building_name 반환
        } else {
          print('Error: ${data['message']}');
          return null;
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching building name: $e');
      return null;
    }
  }
}
