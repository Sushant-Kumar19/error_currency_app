import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/tag_model.dart';
import '../../utils/constants.dart';

class ImaggaService {
  static Future<List<Tag>> recognizeImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(IMAGGA_BASE_URL),
    );

    request.headers['Authorization'] = 'Basic ' +
        base64Encode(utf8.encode('$IMAGGA_API_KEY:$IMAGGA_API_SECRET'));
    request.files.add(
        http.MultipartFile.fromBytes('image', bytes, filename: 'photo.jpg'));

    final response = await request.send();
    final resBody = await response.stream.bytesToString();
    final jsonData = json.decode(resBody);

    if (response.statusCode == 200 && jsonData['result'] != null) {
      List tagsJson = jsonData['result']['tags'];
      return tagsJson.map((e) => Tag.fromJson(e)).toList();
    } else {
      throw Exception('Failed to recognize image');
    }
  }
}
