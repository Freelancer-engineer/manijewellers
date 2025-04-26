import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoService {
  static const String baseUrl = "http://YOUR_IP_OR_DOMAIN:PORT";

  static Future<bool> uploadVideo(String videoUrl) async {
    final url = Uri.parse("$baseUrl/upload_video");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"url": videoUrl}),
    );
    return response.statusCode == 200;
  }
}
