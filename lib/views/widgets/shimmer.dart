import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme.dart';

shimmerListView(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: 70.0,
        child: Shimmer.fromColors(
          baseColor: AppColor.kGreyColor.withOpacity(.2),
          highlightColor: AppColor.kWhiteGreyColor.withOpacity(.4),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.kDarkBackgroundPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    ],
  );
}

circleShimmer(BuildContext context) {
  return Row(
    children: [
      Shimmer.fromColors(
        baseColor: AppColor.kGreyColor.withOpacity(.2),
        highlightColor: AppColor.kWhiteGreyColor.withOpacity(.4),
        child: CircleAvatar(
          backgroundColor: AppColor.kGreyColor,
          radius: 40,
        ),
      ),
    ],
  );
}
