import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingDetailDokterPage extends StatelessWidget {
  const LoadingDetailDokterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   margin: MySpacing.defaultMarginItem,
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.grey[300]!,
          //     highlightColor: Colors.grey[100]!,
          //     child: loadingWidget(
          //         width: double.infinity, height: 230, radius: 10),
          //   ),
          // ),
          // Container(
          //   margin: MySpacing.defaultMarginItem,
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.grey[300]!,
          //     highlightColor: Colors.grey[100]!,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             loadingWidget(width: 100, height: 20, radius: 0),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Row(
          //               children: [
          //                 loadingWidget(width: 65, height: 20, radius: 0),
          //                 const SizedBox(
          //                   width: 8,
          //                 ),
          //                 loadingWidget(width: 50, height: 20, radius: 0),
          //               ],
          //             )
          //           ],
          //         ),
          //         loadingWidget(width: 30, height: 20, radius: 20),
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: MySpacing.defaultMarginItem,
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.grey[300]!,
          //     highlightColor: Colors.grey[100]!,
          //     child: loadingWidget(
          //         width: double.infinity, height: 100, radius: 20),
          //   ),
          // ),
          Container(
            margin: MySpacing.defaultMarginItem,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  loadingWidget(width: 100, height: 20, radius: 0),
                  const SizedBox(
                    height: 10,
                  ),
                  loadingWidget(width: double.infinity, height: 130, radius: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
