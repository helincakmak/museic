import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // API taban URL'si
  final String baseUrl = 'http://127.0.0.1:8000/api/songs/'; 

  // Şarkıları API'den çekmek için bir metot
  Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
