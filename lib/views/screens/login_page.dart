import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_apps/theme.dart';
import '../widgets/animation.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController pwCtr = TextEditingController();
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;
  DateTime? backButtonOnPressedTime;
  bool isSecure = false;

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

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backButtonOnPressedTime == null ||
        currentTime.difference(backButtonOnPressedTime!) >
            const Duration(seconds: 3);
    if (backButton) {
      backButtonOnPressedTime = currentTime;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Tap again",
            style: Style.whiteTextStyle,
          ),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.45,
                      child: Image.asset(
                        "assets/verify.png",
                        scale: 2,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Style.blueTextStyle.copyWith(
                              fontSize: 25.0,
                              fontWeight: Weigth.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      style: Style.whiteGreyTextStyle,
                      controller: emailCtr,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.kDarkBackgroundPrimaryColor,
                        hintText: 'Email',
                        hintStyle: Style.whiteTextStyle,
                        suffixIcon: Icon(
                          Icons.email,
                          color: AppColor.kGreyColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      style: Style.whiteGreyTextStyle,
                      obscureText: !isSecure ? false : true,
                      controller: pwCtr,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.kDarkBackgroundPrimaryColor,
                        hintText: 'Password',
                        hintStyle: Style.whiteTextStyle,
                        suffixIcon: IconButton(
                          icon: Icon(
                            !isSecure ? Icons.visibility : Icons.visibility_off,
                            color: AppColor.kGreyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isSecure = !isSecure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forget password?',
                            style:
                                Style.whiteGreyTextStyle.copyWith(fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              scaleController!.forward();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.kBlueColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 17),
                                child: Text(
                                  "Login",
                                  style: Style.whiteTextStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text.rich(
                        TextSpan(
                            text: 'Don\'t have an account ? ',
                            style:
                                Style.whiteGreyTextStyle.copyWith(fontSize: 15),
                            children: [
                              TextSpan(
                                text: 'Signup',
                                style: Style.blueTextStyle.copyWith(
                                    fontWeight: Weigth.semibold, fontSize: 15),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  scaleController!.forward();
                },
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
                          color: AppColor.kDarkBackgroundPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}