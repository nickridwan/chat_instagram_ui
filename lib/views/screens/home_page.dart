import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_apps/views/widgets/shimmer.dart';
import 'package:music_apps/views/widgets/textfield.dart';
import '../../models/models.dart';
import '../../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String Intro = 'Ridwan Hanif';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> users = [];
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
    });
    setState(() {
      isVisible = false;
    });
    return users;
  }

  @override
  void initState() {
    super.initState();
    log('initState()');
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    log(isVisible.toString());
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text(
                          HomePage.Intro,
                          style: Style.whiteGreyTextStyle.copyWith(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.search,
                              size: 30,
                              color: AppColor.kWhiteGreyColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isSearch = !isSearch;
                                isVisible = !isVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  !isSearch
                      ? Container()
                      : buildFormField(searchCtr, "Cari..."),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Row(
                  children: users
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(e.avatar),
                                radius: 40.0,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                e.username ?? '-',
                                style: Style.whiteGreyTextStyle
                                    .copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
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
              ),
              !isVisible ? Container() : shimmerListView(context),
            ],
          ),
        ),
      ),
    );
  }
}
