import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username, // `email` yerine `username` gönderin
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Başarılı yanıtı JSON formatında döndür
      return json.decode(response.body);
    } else {
      // Hata durumunda detaylı bir istisna fırlat
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['detail'] ?? 'Failed to login';
      throw Exception('Failed to login: $errorMessage');
    }
  }

//liked songs

  Future<void> likeSong(int songId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/liked-songs/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Gerekirse yetkilendirme başlığı ekleyin
      },
      body: json.encode({'song_id': songId}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to like song');
    }
  }
  
  Future<void> unlikeSong(int songId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/liked-songs/$songId/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Gerekirse yetkilendirme başlığı ekleyin
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to unlike song');
    }
  }

//register and signin

  Future<void> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register/'), // Kayıt API endpoint'i
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Kayıt başarılı, yanıt döndürmeye gerek yok
      return;
    } else {
      // Hata durumunda detaylı bir istisna fırlat
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['detail'] ?? 'Failed to register';
      throw Exception('Failed to register: $errorMessage');
    }
  }
}
