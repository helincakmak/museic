import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
final String baseUrl = 'http://10.0.2.2:8000';

  Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/songs/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
