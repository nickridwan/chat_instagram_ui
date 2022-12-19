import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/views/widgets/shimmer.dart';
import 'package:music_apps/views/widgets/textfield.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/models.dart';
import '../../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> users = [];
  List<UserModel> filterUser = [];
  final searchCtr = TextEditingController();
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
      setState(() {
        isVisible = false;
      });
      return users;
    });
  }

  @override
  void initState() {
    super.initState();
    log('initState()');
    getUser();
  }

  message() {
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
                    !isSearch ? CupertinoIcons.xmark : CupertinoIcons.search,
                    size: 30,
                    color: AppColor.kWhiteGreyColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                      filterUser = users
                          .where(
                            (element) =>
                                element.username.toLowerCase().contains(
                                      searchCtr.text.toLowerCase(),
                                    ),
                          )
                          .toList();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        !isSearch ? Container() : buildFormField(searchCtr, "Cari..."),
      ],
    );
  }

  Widget circleStory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ScrollController(),
      child: Row(
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
                      style: Style.whiteGreyTextStyle.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget chatHistory() {
    return isSearch
        ? Column(
            children: users
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: !isVisible
                          ? InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(e.avatar),
                                        radius: 30,
                                      ),
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.username,
                                            style: Style.whiteGreyTextStyle
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: Weigth.semibold,
                                            ),
                                          ),
                                          Text(
                                            "Balasan untuk cerita anda .",
                                            style: Style.whiteGreyTextStyle
                                                .copyWith(
                                              fontSize: 12,
                                              fontWeight: Weigth.regular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.camera,
                                      color: AppColor.kWhiteColor,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : shimmerListView(context),
                    ))
                .toList(),
          )
        : Column(
            children: filterUser
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: !isVisible
                          ? InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(e.avatar),
                                        radius: 30,
                                      ),
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.username,
                                            style: Style.whiteGreyTextStyle
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: Weigth.semibold,
                                            ),
                                          ),
                                          Text(
                                            "Balasan untuk cerita anda .",
                                            style: Style.whiteGreyTextStyle
                                                .copyWith(
                                              fontSize: 12,
                                              fontWeight: Weigth.regular,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.camera,
                                      color: AppColor.kWhiteColor,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : shimmerListView(context),
                    ))
                .toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    log('loading $isVisible');
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              topContent(),
              const SizedBox(
                height: 30,
              ),
              circleStory(),
              message(),
              chatHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
