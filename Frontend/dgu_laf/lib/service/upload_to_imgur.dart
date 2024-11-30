import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> uploadToImgur(File imageFile) async {
  const clientId = '1e9aa96355482d8'; // Imgur 클라이언트 ID
  final url = Uri.parse('https://api.imgur.com/3/image');

  try {
    final bytes = await imageFile.readAsBytes(); // 이미지 파일을 바이트로 읽음
    final base64Image = base64Encode(bytes); // 바이트 데이터를 Base64로 인코딩

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Client-ID $clientId',
      },
      body: {
        'image': base64Image, // Base64로 인코딩된 이미지
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['link']; // 업로드된 이미지 URL 반환
    } else {
      print('Imgur upload failed: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error uploading to Imgur: $e');
    return null;
  }
}
