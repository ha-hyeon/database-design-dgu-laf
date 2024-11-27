import 'package:dgu_laf/model/classroom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClassroomService {
  static const String baseUrl = 'http://192.168.219.105:8080';

  static Future<Classroom> getClassroomById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/classrooms/$id'));
    if (response.statusCode == 200) {
      return Classroom.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch classroom: ${response.statusCode}');
    }
  }
}
