import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingGetTime() {
  return Container(
    margin: MySpacing.defaultMarginItem,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
          loadingWidget(width: 60, height: 30, radius: 10),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    ),
  );
}
