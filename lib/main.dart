import 'package:flutter/material.dart';
import 'package:music_apps/theme.dart';
import 'package:music_apps/views/widgets/camera.dart';
import 'package:music_apps/views/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColor.kBlackColor),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/camera': (context) => const CameraAccess(),
      },
    );
  }
}
