import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_apps/theme.dart';
import 'package:music_apps/views/widgets/splash.dart';
import 'package:music_apps/views/widgets/camera.dart';
import 'package:music_apps/views/screens/home_page.dart';
import 'package:music_apps/views/screens/login_page.dart';
import 'package:music_apps/views/screens/register_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    const InstaApp(),
  );
}

class InstaApp extends StatelessWidget {
  const InstaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColor.kBlackColor),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => Registerpage(),
        '/home': (context) => HomePage(),
        '/camera': (context) => const CameraAccess(),
      },
    );
  }
}
