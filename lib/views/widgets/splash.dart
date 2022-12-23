import 'package:flutter/material.dart';

import '../../theme.dart';
import '../screens/login_page.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Future loading() async {
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      }

      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: loading(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset(
                            "assets/verify.png",
                            scale: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Insta App",
                          style: Style.whiteTextStyle.copyWith(fontSize: 20),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
