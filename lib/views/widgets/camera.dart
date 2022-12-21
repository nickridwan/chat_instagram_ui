import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_apps/views/widgets/take_photo.dart';
import '../../theme.dart';

class CameraAccess extends StatefulWidget {
  const CameraAccess({Key? key}) : super(key: key);

  @override
  State<CameraAccess> createState() => _CameraAccessState();
}

class _CameraAccessState extends State<CameraAccess> {
  final ImagePicker _picker = ImagePicker();

  String pick = "Take a Picture";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 7),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.2,
            decoration: BoxDecoration(
              color: AppColor.kBlackColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.xmark,
                      color: AppColor.kWhiteColor,
                      size: 30.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    pick,
                    style: Style.whiteGreyTextStyle.copyWith(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.kBlueColor,
                      border: Border.all(
                        width: 1,
                        color: AppColor.kWhiteColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/music.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.kWhiteColor.withOpacity(.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (pick == "Take a Picture") {
                                pick = "Damn!!!";
                              } else {
                                pick = "Take a Picture";
                              }
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.photo_camera,
                            color: AppColor.kWhiteColor,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TakePicture(),
                        ),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.camera_rotate,
                      size: 30.0,
                      color: AppColor.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
