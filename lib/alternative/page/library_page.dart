import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/alternative/helper/router.dart';
import 'package:sizer/sizer.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool _isReversed = false;
  List<Map<String, String>> _recentlyPlayedItems = [
    {'title': 'Liked Songs', 'subtitle': 'Playlist • 58 songs', 'iconPath': 'assets/vectors/liked.svg'},
    {'title': 'New Episodes', 'subtitle': 'Updated 2 days ago', 'iconPath': 'assets/vectors/notif_green.svg'},
    {'title': 'Lolo Zouaï', 'subtitle': 'Artist', 'imagePath': 'assets/images/recently3.png'},
    {'title': 'Lana Del Rey', 'subtitle': 'Artist', 'imagePath': 'assets/images/recently1.png'},
    {'title': 'Front Left', 'subtitle': 'Playlist • Spotify', 'imagePath': 'assets/images/recently2.png'},
    {'title': 'Marvin Gaye', 'subtitle': 'Artist', 'imagePath': 'assets/images/recently3.png'},
    {'title': 'Les', 'subtitle': 'Song • Childish Gambino', 'imagePath': 'assets/images/recently1.png'},
  ];
  int selectedChipIndex = -1;

  void _sortRecentlyPlayed() {
    setState(() {
      _recentlyPlayedItems = _recentlyPlayedItems.reversed.toList();
      _isReversed = !_isReversed;
    });
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
                  _buildFilterChip('Playlists', 0),
                  _buildFilterChip('Artists', 1),
                  _buildFilterChip('Albums', 2),
                  _buildFilterChip('Podcasts & shows', 3),
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
                itemCount: _recentlyPlayedItems.length,
                itemBuilder: (context, index) {
                  final item = _recentlyPlayedItems[index];

                  if (item.containsKey('iconPath')) {
                    return _buildSpecialItem(
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                      gradientColors: [
                        Color(0xFF4A39EA),
                        Color(0xFF868AE1),
                        Color(0xFFB9D4DB),
                      ],
                      iconPath: item['iconPath']!,
                    );
                  } else {
                    return _buildRecentlyPlayedItem(
                      item['title']!,
                      item['subtitle']!,
                      item['imagePath']!,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedChipIndex = index;
          });
        },
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: selectedChipIndex == index ? Colors.black : Colors.white,
              fontSize: 13.sp,
            ),
          ),
          backgroundColor: selectedChipIndex == index ? Color(0xFF7F7F7F) : Color(0xFF121212),
          shape: StadiumBorder(
            side: BorderSide(
              color: Color(0xFF7F7F7F),
              width: 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
        ),
      ),
    );
  }

  Widget _buildSpecialItem({
    required String title,
    required String subtitle,
    List<Color>? gradientColors,
    required String iconPath,
  }) {
    return ListTile(
      leading: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 4.w,
            height: 4.w,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Row(
        children: [
          SvgPicture.asset(
            'assets/vectors/pin.svg',
            width: 3.w,
            height: 3.w,
            color: Colors.green,
          ),
          SizedBox(width: 2.w),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildRecentlyPlayedItem(String title, String subtitle, String imagePath) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 12.w,
          height: 12.w,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
      ),
      onTap: () {},
    );
  }
}
