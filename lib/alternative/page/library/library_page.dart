import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/alternative/helper/router.dart';
import 'package:museic/alternative/page/library/widget/filter_chip_widget.dart';
import 'package:museic/alternative/page/library/widget/recently_played_item_widget.dart';
import 'package:museic/alternative/page/library/widget/special_item_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:palette_generator/palette_generator.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isReversed = false;
  bool _isPlayerVisible = false;
  Duration _duration = Duration();
  Duration _position = Duration();
  Color? dominantColor;
  String? currentlyPlayingTitle;
  String? currentlyPlayingArtist;
  String? currentlyPlayingImagePath;
  double _marqueePosition = 0;



  List<Map<String, String>> songs = [
    {
      'title': 'Liked Songs',
      'subtitle': 'Playlist • 58 songs',
      'iconPath': 'assets/vectors/liked.svg',
      'audioPath': 'musics/song1.mp3'
    },
    {
      'title': 'New Episodes',
      'subtitle': 'Updated 2 days ago',
      'iconPath': 'assets/vectors/notif_green.svg',
      'audioPath': 'musics/song2.mp3'
    },
    {
      'title': 'Summertime Sadness (Official Music Video)',
      'subtitle': 'Lana Del Rey',
      'imagePath': 'assets/images/song1.jpg',
      'audioPath': 'musics/song1.mp3'
    },
    {
      'title': 'Something In The Way (Audio)',
      'subtitle': 'Nirvana',
      'imagePath': 'assets/images/song2.jpg',
      'audioPath': 'musics/song2.mp3'
    },
    {
      'title': 'Paint It, Black (Official Lyric Video)',
      'subtitle': 'The Rolling Stones',
      'imagePath': 'assets/images/song3.jpg',
      'audioPath': 'musics/song3.mp3'
    },
    {
      'title': 'Old Town Road (Official Video) ft. Billy Ray Cyrus',
      'subtitle': 'Lil Nas X',
      'imagePath': 'assets/images/song4.jpg',
      'audioPath': 'musics/song4.mp3'
    },
    {
      'title': 'Skyfall (Official Lyric Video)',
      'subtitle': 'Adele',
      'imagePath': 'assets/images/song5.jpg',
      'audioPath': 'musics/song5.mp3'
    },
  ];

  int selectedChipIndex = -1;
  String? currentlyPlaying;

  void _sortRecentlyPlayed() {
    setState(() {
      songs = songs.reversed.toList();
      _isReversed = !_isReversed;
    });
  }

  Future<void> _updateDominantColor(String imagePath) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(imagePath),
    );
    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color ?? Colors.redAccent[700];
    });
  }


  Future<void> _playMusic({
    required String audioPath,
    required String title,
    required String artist,
    required String imagePath,
  }) async {
    try {
      if (currentlyPlaying == audioPath) {
        await _audioPlayer.stop();
        setState(() {
          currentlyPlaying = null;
          _isPlayerVisible = false;
        });
      } else {
        if (currentlyPlaying != null) {
          await _audioPlayer.stop();
        }

        await _updateDominantColor(imagePath);

        await _audioPlayer.setSource(AssetSource(audioPath));
        await _audioPlayer.resume();
        setState(() {
          currentlyPlaying = audioPath;
          currentlyPlayingTitle = title;
          currentlyPlayingArtist = artist;
          currentlyPlayingImagePath = imagePath;
          _isPlayerVisible = true;
          isPlaying = true;
        });
      }
    } catch (e) {
      print('Müzik çalınamadı: $e');
    }
  }


  bool isPlaying = false;

  void _pauseOrResumeMusic() {
    if (isPlaying) {
      _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      _audioPlayer.resume();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _skipForward() {
    final newPosition = _position + Duration(seconds: 10);
    if (newPosition < _duration) {
      _audioPlayer.seek(newPosition);
    }
  }

  void _skipBackward() {
    final newPosition = _position - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      _audioPlayer.seek(newPosition);
    }
  }

  void _startMarqueeAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      if (_isPlayerVisible && currentlyPlayingTitle != null) {
        setState(() {
          _marqueePosition = _marqueePosition == 0 ? -200 : 0;
        });
        _startMarqueeAnimation();
      }
    });
  }


  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _startMarqueeAnimation();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Padding(
        padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 8.w),
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
                        Navigator.pushNamed(context, AppRouter.profilePage);
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChipWidget(
                    label: 'Playlists',
                    index: 0,
                    selectedChipIndex: selectedChipIndex,
                    onChipTap: (index) {
                      setState(() {
                        selectedChipIndex = index;
                      });
                    },
                  ),
                  FilterChipWidget(
                    label: 'Artists',
                    index: 1,
                    selectedChipIndex: selectedChipIndex,
                    onChipTap: (index) {
                      setState(() {
                        selectedChipIndex = index;
                      });
                    },
                  ),
                  FilterChipWidget(
                    label: 'Albums',
                    index: 2,
                    selectedChipIndex: selectedChipIndex,
                    onChipTap: (index) {
                      setState(() {
                        selectedChipIndex = index;
                      });
                    },
                  ),
                  FilterChipWidget(
                    label: 'Podcasts & shows',
                    index: 3,
                    selectedChipIndex: selectedChipIndex,
                    onChipTap: (index) {
                      setState(() {
                        selectedChipIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: _sortRecentlyPlayed,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/arrow_up.svg',
                            width: 4.w,
                            height: 4.w,
                            color: Colors.white,
                          ),
                          Positioned(
                            left: 1,
                            child: SvgPicture.asset(
                              'assets/vectors/arrow_down.svg',
                              width: 4.w,
                              height: 4.w,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Recently played',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final item = songs[index];

                  return Container(
                    color: Colors.transparent,
                    child: item.containsKey('iconPath')
                        ? SpecialItemWidget(
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                      gradientColors: [
                        Color(0xFF4A39EA),
                        Color(0xFF868AE1),
                        Color(0xFFB9D4DB),
                      ],
                      iconPath: item['iconPath']!,
                    )
                        : RecentlyPlayedItemWidget(
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                      imagePath: item['imagePath']!,
                      audioPath: item['audioPath']!,
                      onPlayMusic: () {
                        _playMusic(
                          audioPath: item['audioPath']!,
                          title: item['title']!,
                          artist: item['subtitle']!,
                          imagePath: item['imagePath']!,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            if (_isPlayerVisible)
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.w),
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: dominantColor ?? Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                currentlyPlayingImagePath ?? 'assets/images/default_song_image.png',
                                width: 10.w,
                                height: 10.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(seconds: 2),
                                    transform: Matrix4.translationValues(_marqueePosition, 0, 0),
                                    child: Text(
                                      currentlyPlayingTitle ?? 'Unknown Title',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    currentlyPlayingArtist ?? 'Unknown Artist',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                              onPressed: _pauseOrResumeMusic,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5.w,
                    left: 5.w,
                    right: 5.w,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.transparent,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                      ),
                      child: Slider(
                        activeColor: Color(0xffB2B2B2),
                        inactiveColor: Color(0xffB2B2B2).withOpacity(0.5),
                        min: 0.0,
                        max: _duration.inSeconds.toDouble(),
                        value: _position.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
