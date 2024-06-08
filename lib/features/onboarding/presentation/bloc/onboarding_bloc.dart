import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnBoardingLocalDataSource onBoardingLocalDataSource;

  OnboardingBloc({required this.onBoardingLocalDataSource})
      : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      emit(OnBoardingLoading());
    });
    on<OnGetOnBoarding>(
      (event, emit) async {
        final response = await onBoardingLocalDataSource.getOnBoarding();
        emit(
          OnBoardingSuccess(isOnBoarding: response),
        );
      },
    );
    on<OnAddBoarding>(
      (event, emit) async {
        await onBoardingLocalDataSource.addOnBoarding();
        emit(AddOnBoardingSuccess());
      },
    );
  }
}
