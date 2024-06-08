part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnBoardingSuccess extends OnboardingState {
  final bool isOnBoarding;

  OnBoardingSuccess({required this.isOnBoarding});
}

final class OnBoardingLoading extends OnboardingState {}

final class AddOnBoardingSuccess extends OnboardingState {}
