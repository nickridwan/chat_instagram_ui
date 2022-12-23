import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

searchField(
  BuildContext context,
  TextEditingController controller,
  VoidCallback acivate,
  VoidCallback changed,
  String hint,
) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      style: Style.whiteGreyTextStyle
          .copyWith(fontWeight: Weigth.medium, fontSize: 15),
      keyboardType: TextInputType.name,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.kGreyColor.withOpacity(.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
        suffixIcon: IconButton(
          onPressed: () {
            acivate;
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
        changed;
      },
    ),
  );
}

messageField(
  BuildContext context,
  TextEditingController controller,
  bool isMessage,
  VoidCallback changeIcon,
  VoidCallback galery,
  VoidCallback camera,
  VoidCallback validator,
) {
  return Container(
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
        controller: controller,
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
                    changeIcon;
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
                    galery;
                  },
                  icon: Icon(
                    CupertinoIcons.photo,
                    size: 24.0,
                    color: AppColor.kWhiteColor,
                  ),
                ),
          prefixIcon: IconButton(
            onPressed: () async {
              camera;
            },
            icon: Icon(
              CupertinoIcons.camera_circle_fill,
              color: AppColor.kBlueColor,
              size: 45,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints.expand(width: 55, height: 60),
          hintStyle: Style.whiteGreyTextStyle
              .copyWith(fontWeight: Weigth.medium, fontSize: 15),
        ),
        onChanged: (value) {
          validator;
        },
      ),
    ),
  );
}
