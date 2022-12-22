import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_apps/theme.dart';
import 'package:music_apps/views/widgets/camera.dart';
import 'package:music_apps/views/screens/home_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
