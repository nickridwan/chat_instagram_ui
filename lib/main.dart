import 'package:flutter/material.dart';
import 'package:music_apps/views/screens/collection.dart';
import 'package:music_apps/views/screens/home_page.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/collection': (context) => const CollectionPage(),
      },
    );
  }
}
