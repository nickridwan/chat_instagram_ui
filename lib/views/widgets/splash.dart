import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../theme.dart';
import '../screens/home_page.dart';
import 'animation.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.push(
              context,
              AnimatingRoute(
                route: HomePage(),
                page: HomePage(),
              ),
            );
            Timer(
              const Duration(milliseconds: 300),
              () {
                scaleController!.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(scaleController!);
  }

  @override
  void dispose() {
    scaleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Future loading() async {
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            scaleController!.forward();
            isLoading = true;
          });
        });
      }

      return Scaffold(
        body: Stack(
          children: [
            Container(
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
                              "INSTA APPLICATION",
                              style:
                                  Style.whiteTextStyle.copyWith(fontSize: 20),
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
            Center(
              child: isLoading ? boxAnimated() : Container(),
            )
          ],
        ),
      );
    });
  }

  boxAnimated() {
    return Center(
      child: InkWell(
        onTap: () {
          scaleController!.forward();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: AnimatedBuilder(
              animation: scaleAnimation!,
              builder: (c, child) => Transform.scale(
                scale: scaleAnimation!.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.kBlueColor.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
