import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

Widget buildFormField(
  TextEditingController controller,
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
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: AppColor.kWhiteColor,
          size: 24.0,
        ),
        hintStyle: Style.whiteGreyTextStyle
            .copyWith(fontWeight: Weigth.medium, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}
