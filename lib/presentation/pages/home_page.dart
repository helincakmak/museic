import 'package:flutter/material.dart';
import 'package:museic/core/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _songs;

  @override
  void initState() {
    super.initState();
    _songs = ApiService().fetchSongs(); // ApiService'den şarkı verilerini çekiyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _songs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No songs available.'));
          } else {
            final songs = snapshot.data!;
            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  title: Text(song['title']),
                  subtitle: Text(song['album']['title']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
