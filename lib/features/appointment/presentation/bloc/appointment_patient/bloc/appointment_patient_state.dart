part of 'appointment_patient_bloc.dart';

@immutable
sealed class AppointmentPatientState {}

final class AppointmentPatientInitial extends AppointmentPatientState {}

final class AppointmentPatientLoading extends AppointmentPatientState {}

final class AppointmentPatientError extends AppointmentPatientState {
  final String message;

  AppointmentPatientError({required this.message});
}

final class AppointmentPatientLoaded extends AppointmentPatientState {
  final List<AppointmentPatient> appointments;

  AppointmentPatientLoaded({required this.appointments});
}
