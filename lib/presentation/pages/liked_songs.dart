import 'package:flutter/material.dart';
import 'package:museic/core/api_service.dart';
import 'package:museic/presentation/pages/songEntity.dart';
import 'package:museic/presentation/pages/songPlayerPage.dart';
import 'package:museic/core/configs/theme/app_colors.dart';

class LikedSongs extends StatefulWidget {
  final Set<int> likedSongIds;
  final Future<void> Function(int songId) toggleLike;
  final bool Function(int songId) isLiked;

  const LikedSongs({
    required this.likedSongIds,
    required this.toggleLike,
    required this.isLiked,
    super.key,
  });

  @override
  _LikedSongsState createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  late Future<List<SongEntity>> _futureSongs;

  @override
  void initState() {
    super.initState();
    _futureSongs = ApiService().fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongEntity>>(
      future: _futureSongs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Şarkı bulunamadı.'));
        } else {
          List<SongEntity> songs = snapshot.data!;
          final likedSongs = songs.where((song) => widget.likedSongIds.contains(song.id)).toList();

          return ListView.builder(
            itemCount: likedSongs.length,
            itemBuilder: (context, index) {
              final song = likedSongs[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.album.artist.name), // Güncellenmiş alan adı
                trailing: IconButton(
                  icon: Icon(
                    widget.isLiked(song.id) ? Icons.favorite : Icons.favorite_border,
                    color: widget.isLiked(song.id) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () async {
                    await widget.toggleLike(song.id);
                    setState(() {}); // likedSongIds setini güncelle
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                        songEntity: song,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
