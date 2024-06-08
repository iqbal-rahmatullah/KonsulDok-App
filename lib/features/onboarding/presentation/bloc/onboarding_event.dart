part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

final class OnAddBoarding extends OnboardingEvent {}

final class OnGetOnBoarding extends OnboardingEvent {}
