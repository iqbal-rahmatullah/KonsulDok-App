import 'package:hive/hive.dart';

final class OnBoardingLocalDataSource {
  final Box<bool> box;

  OnBoardingLocalDataSource({required this.box});

  Future<void> addOnBoarding() async {
    await box.put('onboarding', true);
  }

  Future<bool> getOnBoarding() async {
    return box.get('onboarding') ?? false;
  }
}
