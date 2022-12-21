import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_apps/models/message.dart';
import 'package:music_apps/models/models.dart';

import '../../theme.dart';

class ChatPage extends StatefulWidget {
  UserModel user;
  ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = TextEditingController();
  bool isMessage = false;
  String selectedImagePath = '';
  bool isAccount = false;

  @override
  void dispose() {
    log("Chat: dispose()");
    super.dispose();
  }

  @override
  void deactivate() {
    log("Chat: deactivate()");
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    log("Chat: didChangeDepedencies()");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("Chat: didUpdateWidget()");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kBlackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 24.0,
            color: AppColor.kWhiteColor,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.avatar),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.username,
                  style: Style.whiteTextStyle
                      .copyWith(fontSize: 15, fontWeight: Weigth.semibold),
                ),
                Text(
                  "Sedang aktif",
                  style: Style.whiteGreyTextStyle.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.phone,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.video_camera,
              size: 35.0,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.1,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.avatar),
                  radius: 55.0,
                ),
                Text(
                  widget.user.username,
                  style: Style.whiteTextStyle
                      .copyWith(fontWeight: Weigth.bold, fontSize: 16),
                ),
                Text(
                  "Instagram",
                  style: Style.whiteTextStyle
                      .copyWith(fontWeight: Weigth.medium, fontSize: 13),
                ),
                Text(
                  "100K pengikut - 1 postingan\n Anda mengikuti akun instagram ini sejak 1950",
                  textAlign: TextAlign.center,
                  style: Style.greyTextStyle.copyWith(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.kGreyColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    child: Text(
                      "Lihat profile",
                      style: Style.whiteTextStyle
                          .copyWith(fontSize: 13, fontWeight: Weigth.semibold),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: message.length,
                itemBuilder: (context, index) {
                  log("type: ${message[index].type}");
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Align(
                      alignment: (message[index].type != 1
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: (message[index].id == widget.user.id)
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (message[index].type != 1
                                    ? AppColor.kGreyColor.withOpacity(.5)
                                    : AppColor.kBlueColor),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                message[index].msg,
                                style: Style.whiteTextStyle,
                              ),
                            )
                          : Container(),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.kDarkBackgroundPrimaryColor,
                borderRadius: BorderRadius.circular(16),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: Style.whiteTextStyle
                      .copyWith(fontWeight: Weigth.medium, fontSize: 15),
                  keyboardType: TextInputType.name,
                  controller: chatController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    isCollapsed: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: ' Pesan...',
                    suffixIcon: isMessage
                        ? TextButton(
                            onPressed: () {
                              message.add(
                                Message(
                                  id: widget.user.id,
                                  msg: chatController.text,
                                  type: 1,
                                  date: DateTime.now(),
                                ),
                              );
                              chatController.clear();
                              setState(() {});
                            },
                            child: Text(
                              "Send",
                              style: Style.blueTextStyle.copyWith(
                                fontWeight: Weigth.semibold,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              selectedImagePath =
                                  await selectImageFromGallery();
                              log('Image_Path:-');
                              log(selectedImagePath);
                              if (selectedImagePath != '') {
                                Navigator.pop(context);
                                setState(() {});
                              } else {
                                log("No Image Capture");
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              CupertinoIcons.photo,
                              size: 24.0,
                              color: AppColor.kWhiteColor,
                            ),
                          ),
                    prefixIcon: IconButton(
                      onPressed: () async {
                        selectedImagePath = await selectImageFromCamera();
                        log('Image_Path:-');
                        log(selectedImagePath);

                        if (selectedImagePath != '') {
                          Navigator.pop(context);
                          setState(() {});
                        } else {
                          log("No Image Capture");
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.camera_circle_fill,
                        color: AppColor.kBlueColor,
                        size: 45,
                      ),
                    ),
                    prefixIconConstraints:
                        BoxConstraints.expand(width: 55, height: 60),
                    hintStyle: Style.whiteGreyTextStyle
                        .copyWith(fontWeight: Weigth.medium, fontSize: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (chatController.text.isNotEmpty) {
                        isMessage = true;
                      } else {
                        isMessage = false;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectImageFromGallery() async {
    File? file = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 10) as File;
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    File? file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 10) as File;
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
