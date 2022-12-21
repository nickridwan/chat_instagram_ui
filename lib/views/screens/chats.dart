import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/models/models.dart';

import '../../theme.dart';

class CollectionPage extends StatefulWidget {
  UserModel chat;
  CollectionPage({super.key, required this.chat});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final chatController = TextEditingController();
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

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
              backgroundImage: NetworkImage(widget.chat.avatar),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.username,
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
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.chat.avatar),
                  radius: 55.0,
                ),
                Text(
                  widget.chat.username,
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
              child: Container(
                color: Colors.transparent,
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Text(
                        "",
                        style: Style.whiteTextStyle.copyWith(fontSize: 20),
                      );
                    }),
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
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                child: TextFormField(
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
                    hintText: 'Pesan...',
                    suffixIcon: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.mic,
                            size: 24.0,
                            color: AppColor.kWhiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.photo,
                            size: 24.0,
                            color: AppColor.kWhiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.rectangle_paperclip,
                            size: 24.0,
                            color: AppColor.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.camera_circle_fill,
                      color: AppColor.kBlueColor,
                      size: 45,
                    ),
                    hintStyle: Style.whiteGreyTextStyle
                        .copyWith(fontWeight: Weigth.medium, fontSize: 15),
                  ),
                  onChanged: (value) {
                    log(chatController.toString());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
