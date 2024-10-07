import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:museic/presentation/pages/songEntity.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Şarkı listesini çeken servis
  Future<List<SongEntity>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<SongEntity> songs = data.map((json) => SongEntity.fromJson(json)).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  // Sanatçı listesini çeken servis
  Future<List<ArtistEntity>> fetchArtists() async {
    final response = await http.get(Uri.parse('$baseUrl/api/artists/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<ArtistEntity> artists = data.map((json) => ArtistEntity.fromJson(json)).toList();
      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  // Albüm listesini çeken servis
  Future<List<AlbumEntity>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/api/albums/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<AlbumEntity> albums = data.map((json) => AlbumEntity.fromJson(json)).toList();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
