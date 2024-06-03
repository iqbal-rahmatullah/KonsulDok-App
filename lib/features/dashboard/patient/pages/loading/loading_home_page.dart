import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/widgets/loading_widget.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHomePage extends StatelessWidget {
  const LoadingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MySpacing.paddingPage,
        child: Column(
          children: [
            Container(
              margin: MySpacing.defaultMarginItem,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        loadingWidget(width: 40, height: 40, radius: 10),
                        const SizedBox(
                          width: 10,
                        ),
                        loadingWidget(width: 120, height: 20),
                      ],
                    ),
                    loadingWidget(width: 40, height: 40, radius: 50),
                  ],
                ),
              ),
            ),
            Container(
              margin: MySpacing.defaultMarginItem,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: loadingWidget(
                    width: double.infinity, height: 40, radius: 30),
              ),
            ),
            Container(
              margin: MySpacing.defaultMarginItem,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          loadingWidget(width: 60, height: 20),
                          loadingWidget(width: 80, height: 20),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        children: List.generate(8, (index) {
                          return Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: MyColor.gradientBiru,
                                ),
                                child: loadingWidget(
                                    width: 50, height: 50, radius: 50),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              loadingWidget(width: 30, height: 10),
                            ],
                          );
                        }),
                      ),
                      Container(
                        margin: MySpacing.defaultMarginItem,
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    loadingWidget(width: 60, height: 20),
                                    loadingWidget(width: 80, height: 20),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                loadingWidget(
                                    width: double.infinity,
                                    height: 150,
                                    radius: 20),
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
