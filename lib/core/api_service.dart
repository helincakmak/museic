import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000';  // Django API'nizin URL'si

  Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
