part of 'update_status_appointment_bloc.dart';

@immutable
sealed class UpdateStatusAppointmentEvent {}

final class OnUpdateStatusAppointment extends UpdateStatusAppointmentEvent {
  final int appointmentId;
  final String status;

  OnUpdateStatusAppointment(this.appointmentId, this.status);
}
