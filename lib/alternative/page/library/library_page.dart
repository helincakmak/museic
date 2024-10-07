import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../core/api_service.dart';
import '../../../presentation/pages/songEntity.dart';
import 'home_wrapper/home_wrapper_page.dart';

class LibraryPage extends StatefulWidget {
  final Function(SongEntity) onPlayMusic;

  LibraryPage({required this.onPlayMusic});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Color? dominantColor;
  String? currentlyPlayingTitle;
  String? currentlyPlayingArtist;
  String? currentlyPlayingImagePath;

  List<SongEntity> songs = [];
  List<ArtistEntity> artists = [];
  List<AlbumEntity> albums = [];

  int selectedChipIndex = -1;
  SongEntity? currentlyPlaying;

  @override
  void initState() {
    super.initState();
    _fetchItemsFromService();
  }

  Future<void> _fetchItemsFromService() async {
    try {
      var fetchedSongs = await ApiService().fetchSongs();
      var fetchedArtists = await ApiService().fetchArtists();
      var fetchedAlbums = await ApiService().fetchAlbums();
      setState(() {
        songs = fetchedSongs;
        artists = fetchedArtists;
        albums = fetchedAlbums;
      });
    } catch (e) {
      print('Veriler alınırken hata oluştu: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 8.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final wrapperState = context.findAncestorStateOfType<HomePageWrapperState>();
                              wrapperState?.navigateToProfilePage();
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Your Library',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    child: Text(
                      "Artists",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: artists.length,
                    itemBuilder: (context, index) {
                      final artist = artists[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: artist.photo != null ? NetworkImage(artist.photo!) : null,
                          child: artist.photo == null
                              ? Text(artist.name[0], style: TextStyle(fontSize: 24, color: Colors.white))
                              : null,
                        ),
                        title: Text(
                          artist.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          artist.genre,
                          style: TextStyle(color: Colors.white54),
                        ),
                        onTap: () {
                          final artistSongs = songs.where((song) => song.album.artist.id == artist.id).toList();

                          final wrapperState = context.findAncestorStateOfType<HomePageWrapperState>();
                          wrapperState?.navigateToArtistProfile(
                            artist.name,
                            artist.photo ?? 'default_image.png',
                            artist.genre,
                            artistSongs,
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    child: Text(
                      "Albums",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      final album = albums[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: album.coverImage != null ? NetworkImage(album.coverImage!) : null,
                          child: album.coverImage == null
                              ? Text(album.title[0], style: TextStyle(fontSize: 24, color: Colors.white))
                              : null,
                        ),
                        title: Text(
                          album.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          album.artist.name,
                          style: TextStyle(color: Colors.white54),
                        ),
                        onTap: () {},
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    child: Text(
                      "Songs",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: song.coverImage != null ? NetworkImage(song.coverImage!) : null,
                          child: song.coverImage == null
                              ? Text(song.title[0], style: TextStyle(fontSize: 24, color: Colors.white))
                              : null,
                        ),
                        title: Text(
                          song.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          song.album.artist.name,
                          style: TextStyle(color: Colors.white54),
                        ),
                        onTap: () {
                          widget.onPlayMusic(song);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
