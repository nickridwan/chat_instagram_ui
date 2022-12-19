import 'package:flutter/material.dart';
import '../../theme.dart';

Widget buildFormField(
  TextEditingController controller,
  String hint,
) {
  return SizedBox(
    height: 60,
    child: TextFormField(
      style: Style.whiteGreyTextStyle
          .copyWith(fontWeight: Weigth.medium, fontSize: 15),
      keyboardType: TextInputType.name,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.1, color: AppColor.kRedColor),
        ),
        hintText: hint,
        hintStyle: Style.whiteGreyTextStyle
            .copyWith(fontWeight: Weigth.medium, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}
