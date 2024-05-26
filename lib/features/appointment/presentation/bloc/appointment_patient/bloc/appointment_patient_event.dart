part of 'appointment_patient_bloc.dart';

@immutable
sealed class AppointmentPatientEvent {}

final class GetAppointmentPatientEvent extends AppointmentPatientEvent {
  final int id;

  GetAppointmentPatientEvent({required this.id});
}
