import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_apps/models/message.dart';
import 'package:music_apps/views/screens/chats.dart';
import 'package:music_apps/views/widgets/page_transition.dart';
import 'package:music_apps/views/widgets/shimmer.dart';
import '../../models/models.dart';
import '../../theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? backButtonOnPressedTime;
  List<UserModel> users = [];
  List<Message> message = [];
  List<UserModel> filterUser = [];

  final searchCtr = TextEditingController();
  String selectedImagePath = '';

  bool isField = false;
  bool isSearch = false;
  bool isVisible = false;

  Future getUser() async {
    setState(() {
      isVisible = true;
    });
    users.clear();
    UserModel.getDataUser().then((value) {
      setState(() {
        for (var i = 0; i < value.length; i++) {
          users.add(value[i]);
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          isVisible = false;
        });
      });

      return users;
    });
  }

  @override
  void initState() {
    super.initState();
    log('HomePage: initState()');
    getUser();
  }

  @override
  void dispose() {
    log("HomePage: dispose()");
    super.dispose();
  }

  @override
  void deactivate() {
    log("HomePage: deactivate()");
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    log("HomePage: didChangeDepedencies()");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("HomePage: didUpdateWidget()");
  }

  option() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pesan",
            style: Style.whiteGreyTextStyle,
          ),
          Text(
            "Permintaan",
            style: Style.blueTextStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget topContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                'Ridwan Hanif',
                style: Style.whiteGreyTextStyle.copyWith(
                  fontSize: 25,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isField ? CupertinoIcons.xmark : CupertinoIcons.search,
                    size: 30,
                    color: AppColor.kWhiteGreyColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isField = !isField;
                      if (isSearch == true || isField == false) {
                        searchCtr.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        !isField ? Container() : buildFormField(),
      ],
    );
  }

  Widget buildFormField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: Style.whiteGreyTextStyle
            .copyWith(fontWeight: Weigth.medium, fontSize: 15),
        keyboardType: TextInputType.name,
        controller: searchCtr,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.kGreyColor.withOpacity(.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: "Cari...",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                searchCtr.clear();
                isSearch = false;
              });
            },
            icon: Icon(
              CupertinoIcons.xmark_circle,
              size: 24.0,
              color: AppColor.kRedColor,
            ),
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: AppColor.kWhiteColor,
            size: 20,
          ),
          hintStyle: Style.whiteGreyTextStyle
              .copyWith(fontWeight: Weigth.medium, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onChanged: (value) {
          setState(() {
            isVisible = true;
          });
          isSearch = true;
          setState(
            () {
              filterUser = users
                  .where(
                    (element) => element.username.toLowerCase().contains(
                          searchCtr.text.toLowerCase(),
                        ),
                  )
                  .toList();
            },
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              isVisible = false;
            });
          });
        },
      ),
    );
  }

  Widget circleStory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                !isVisible
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/music.jpg'),
                        radius: 40.0,
                      )
                    : circleShimmer(context),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'anda',
                  style: Style.whiteGreyTextStyle
                      .copyWith(fontSize: 12, fontWeight: Weigth.bold),
                ),
              ],
            ),
          ),
          Row(
            children: users
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        !isVisible
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(e.avatar),
                                radius: 40.0,
                              )
                            : circleShimmer(context),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          e.username,
                          style: Style.whiteGreyTextStyle
                              .copyWith(fontSize: 12, fontWeight: Weigth.bold),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget chatHistory() {
    return Expanded(
      child: ListView.builder(
        itemCount: !isSearch ? users.length : filterUser.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(
                context,
                createRoute(
                  ChatPage(
                    user: !isSearch ? users[index] : filterUser[index],
                  ),
                ),
              );
              log('chat');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: !isVisible
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(!isSearch
                                  ? users[index].avatar
                                  : filterUser[index].avatar),
                              radius: 30,
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  !isSearch
                                      ? users[index].username
                                      : filterUser[index].username,
                                  style: Style.whiteGreyTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: Weigth.semibold,
                                  ),
                                ),
                                Text(
                                  'membalas cerita anda',
                                  // message[index].msg ?? '-',
                                  style: Style.whiteGreyTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: Weigth.regular,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            selectedImagePath = await selectImageFromCamera();
                            log('Image_Path:-');
                            log(selectedImagePath);
                            if (selectedImagePath != '') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Success",
                                      style: Style.greenTextStyle),
                                ),
                              );
                              setState(() {});
                            } else {
                              // ignore: use_build_context_synchronously
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   content: Text(
                              //     "No Image Captured !",
                              //     style: Style.whiteTextStyle,
                              //   ),
                              // ));
                              log("No Image Captured");
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.camera,
                            color: AppColor.kWhiteColor,
                            size: 24.0,
                          ),
                        ),
                      ],
                    )
                  : shimmerListView(context),
            ),
          );
        },
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backButtonOnPressedTime == null ||
        currentTime.difference(backButtonOnPressedTime!) > Duration(seconds: 3);
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
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              topContent(),
              const SizedBox(
                height: 30,
              ),
              circleStory(),
              option(),
              chatHistory(),
            ],
          ),
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
