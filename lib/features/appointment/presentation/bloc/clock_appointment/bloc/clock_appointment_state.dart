part of 'clock_appointment_bloc.dart';

@immutable
sealed class ClockAppointmentState {}

final class ClockAppointmentInitial extends ClockAppointmentState {}

final class ClockAppointmentLoading extends ClockAppointmentState {}

final class ClockAppointmentError extends ClockAppointmentState {
  final String message;

  ClockAppointmentError(this.message);
}

final class ClockAppointmentLoaded extends ClockAppointmentState {
  final List<ClockAppointment> clockAppointments;

  ClockAppointmentLoaded(this.clockAppointments);
}
