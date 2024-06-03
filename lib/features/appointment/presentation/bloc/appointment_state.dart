part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentState {}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentLoading extends AppointmentState {}

final class AppointmentSuccess extends AppointmentState {
  final Appointment appointment;

  AppointmentSuccess(this.appointment);
}

final class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError(this.message);
}
