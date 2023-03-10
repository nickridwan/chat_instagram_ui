import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/controllers/dummy.dart';
import 'package:music_apps/theme.dart';
import '../../models/dummy_model.dart';
import '../widgets/animation.dart';
import 'home_page.dart';
import 'dart:developer';

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
  bool isLoading = false;
  List<dynamic> dummyUser = [];
  List<dynamic> dummyFilter = [];

  Future dummyFetch() async {
    setState(() {
      dummyUser.add(authLogin['data']);
    });
    return dummyUser;
  }

  @override
  void initState() {
    super.initState();

    dummyFetch();

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
  void deactivate() {
    log("LoginPage: deactivate()");
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    log("loginPage: didChangeDepedencies()");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("loginPage: didUpdateWidget()");
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

  brandPage() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
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
      ],
    );
  }

  inputLogin() {
    return Column(
      children: [
        TextField(
          style: Style.whiteGreyTextStyle,
          controller: emailCtr,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
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
          // onChanged: (value) {
          //   dummyFilter = dummyUser
          //       .where((element) => element.username.contains(emailCtr.text))
          //       .toList();
          //   setState(() {});
          // },
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextField(
          style: Style.whiteGreyTextStyle,
          textInputAction: TextInputAction.done,
          obscureText: isSecure ? false : true,
          controller: pwCtr,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.kDarkBackgroundPrimaryColor,
            hintText: 'Password',
            hintStyle: Style.whiteTextStyle,
            suffixIcon: IconButton(
              icon: Icon(
                isSecure ? Icons.visibility : Icons.visibility_off,
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
          // onChanged: (value) {
          //   dummyFilter = dummyUser
          //       .where((element) => element.password.contains(pwCtr.text))
          //       .toList();
          //   setState(() {});
          // },
          onSubmitted: (value) {
            if (emailCtr.text.isEmpty || pwCtr.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Please input this field",
                    style: Style.whiteTextStyle,
                  ),
                ),
              );
            } else if (emailCtr.text == email && pwCtr.text == password) {
              scaleController!.forward();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.kRedColor,
                content: Text(
                  "System Error",
                  style: Style.whiteTextStyle,
                ),
              ));
            }
          },
        ),
      ],
    );
  }

  loginConfirm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Forget password?',
                style: Style.whiteGreyTextStyle.copyWith(fontSize: 15),
              ),
              buttonLogin(),
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
                style: Style.whiteGreyTextStyle.copyWith(fontSize: 15),
                children: [
                  TextSpan(
                    text: 'Signup',
                    style: Style.blueTextStyle
                        .copyWith(fontWeight: Weigth.semibold, fontSize: 15),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  String email = "ridwanhanif@gmail.com";
  String password = "crb123";

  buttonLogin() {
    return InkWell(
      onTap: () {
        if (emailCtr.text.isEmpty || pwCtr.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Please input this field",
                style: Style.whiteTextStyle,
              ),
            ),
          );
        } else if (emailCtr.text == email && pwCtr.text == password) {
          scaleController!.forward();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.kRedColor,
            content: Text(
              "System Error",
              style: Style.whiteTextStyle,
            ),
          ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.kBlueColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          child: Text(
            "Login",
            style: Style.whiteTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log(' ini status login kontol : $isLoading');
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    brandPage(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    inputLogin(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    loginConfirm(),
                  ],
                ),
              ),
            ),
            isLoading ? circularLoading() : boxAnimated(),
          ],
        ),
      ),
    );
  }

  boxAnimated() {
    return Center(
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
    );
  }

  circularLoading() {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 40,
        color: AppColor.kWhiteColor,
      ),
    );
  }
}
