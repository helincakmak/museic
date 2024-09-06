import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:museic/presentation/pages/songEntity.dart'; // Import SongEntity

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<List<SongEntity>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/'));

    if (response.statusCode == 200) {
      // Decode the response body
      final List<dynamic> data = json.decode(response.body);

      // Map JSON data to SongEntity
      List<SongEntity> songs = data.map((json) => SongEntity.fromJson(json)).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
