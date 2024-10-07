class ArtistEntity {
  final int id;
  final String name;
  final String genre;
  final String? photo;

  ArtistEntity({
    required this.id,
    required this.name,
    required this.genre,
    this.photo,
  });

  factory ArtistEntity.fromJson(Map<String, dynamic> json) {
    return ArtistEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      genre: json['genre'] as String,
      photo: json['photo'] as String?,
    );
  }
}


class AlbumEntity {
  final int id;
  final ArtistEntity artist;
  final String title;
  final String releaseDate;
  final String? coverImage;  // Fotoğraf opsiyonel olabilir

  AlbumEntity({
    required this.id,
    required this.artist,
    required this.title,
    required this.releaseDate,
    this.coverImage,  // Opsiyonel alan
  });

  factory AlbumEntity.fromJson(Map<String, dynamic> json) {
    return AlbumEntity(
      id: json['id'] as int,
      artist: ArtistEntity.fromJson(json['artist']),
      title: json['title'] as String,
      releaseDate: json['release_date'] as String,
      coverImage: json['cover_image'] != null ? json['cover_image'] as String : null,  // Null kontrolü
    );
  }
}



// Define the SongEntity model
class SongEntity {
  final int id;
  final AlbumEntity album;
  final String title;
  final String duration;
  final String releaseDate;
  final String file;
  final String? coverImage;  // Fotoğraf opsiyonel olabilir

  SongEntity({
    required this.id,
    required this.album,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.file,
    this.coverImage,  // Opsiyonel alan
  });

  factory SongEntity.fromJson(Map<String, dynamic> json) {
    return SongEntity(
      id: json['id'] as int,
      album: AlbumEntity.fromJson(json['album']),
      title: json['title'] as String,
      duration: json['duration'] as String,
      releaseDate: json['release_date'] as String,
      file: json['file'] as String,
      coverImage: json['cover_image'] != null ? json['cover_image'] as String : null,  // Null kontrolü
    );
  }
}
