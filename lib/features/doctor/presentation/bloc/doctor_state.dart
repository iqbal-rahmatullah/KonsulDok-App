part of 'doctor_bloc.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorGetCategoryLoaded extends DoctorState {
  final List<Doctor> doctors;

  DoctorGetCategoryLoaded({required this.doctors});
}

final class DoctorError extends DoctorState {
  final String message;

  DoctorError({required this.message});
}
