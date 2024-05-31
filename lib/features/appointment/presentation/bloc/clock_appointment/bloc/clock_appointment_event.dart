part of 'clock_appointment_bloc.dart';

@immutable
sealed class ClockAppointmentEvent {}

final class GetClockAppointmentEvent extends ClockAppointmentEvent {
  final int doctorId;
  final String date;

  GetClockAppointmentEvent({required this.doctorId, required this.date});
}
