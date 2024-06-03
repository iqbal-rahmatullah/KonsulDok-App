part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentEvent {}

class CreateAppointmentEvent extends AppointmentEvent {
  final int patientId;
  final int doctorId;
  final String date;
  final String time;

  CreateAppointmentEvent({
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.time,
  });
}
