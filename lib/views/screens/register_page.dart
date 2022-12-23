import 'package:flutter/material.dart';
import 'package:music_apps/theme.dart';

class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController pwCtr = TextEditingController();
  bool isSecure = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
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
                      'Register',
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
                controller: usernameCtr,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.kDarkBackgroundPrimaryColor,
                  hintText: 'Username',
                  hintStyle: Style.whiteTextStyle,
                  suffixIcon: Icon(
                    Icons.person,
                    color: AppColor.kWhiteColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                    color: AppColor.kWhiteColor,
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
                      color: AppColor.kWhiteColor,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.kBlueColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    'Daftar',
                    style: Style.whiteTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
