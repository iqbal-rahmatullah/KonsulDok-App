import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: MyColor.biruIndicator,
        ),
      ),
    );
  }
}
