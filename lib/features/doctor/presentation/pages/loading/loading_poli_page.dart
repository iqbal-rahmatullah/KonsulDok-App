import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPoliPage extends StatelessWidget {
  const LoadingPoliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(6, (index) {
      return Container(
        margin: MySpacing.defaultMarginItem,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: loadingWidget(width: double.infinity, height: 100, radius: 10),
        ),
      );
    }));
  }
}
