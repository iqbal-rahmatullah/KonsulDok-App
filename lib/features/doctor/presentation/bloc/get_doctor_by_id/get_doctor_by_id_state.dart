part of 'get_doctor_by_id_bloc.dart';

@immutable
sealed class GetDoctorByIdState {}

final class GetDoctorByIdInitial extends GetDoctorByIdState {}

final class GetDoctorByIdLoading extends GetDoctorByIdState {}

final class GetDoctorByIdLoaded extends GetDoctorByIdState {
  final Doctor doctor;

  GetDoctorByIdLoaded({required this.doctor});
}

final class GetDoctorByIdError extends GetDoctorByIdState {
  final String message;

  GetDoctorByIdError({required this.message});
}
