import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> uploadImage({
  required int itemId,
  required String imageUrl,
}) async {
  print('Uploading image...');
  print('Item ID: $itemId');
  print('Image URL: $imageUrl');

  final response = await http.post(
    Uri.parse('http://192.168.219.105/dgulaf/images.php?action=upload'),
    body: {
      'item_id': itemId.toString(),
      'image_url': imageUrl,
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  final responseBody = json.decode(response.body);
  if (responseBody['status'] == 'success') {
    return responseBody;
  } else {
    throw Exception('Failed to upload image');
  }
}

Future<List<String>> fetchItemImages(int itemId) async {
  final response = await http.get(
    Uri.parse('http://192.168.219.103/dgulaf/images.php?item_id=$itemId'),
  );

  List<dynamic> data = json.decode(response.body);
  return List<String>.from(data.map((item) => item['image_url']));
}
