part of 'check_rating_appointment_bloc.dart';

@immutable
sealed class CheckRatingAppointmentEvent {}

class OnCheckRatingAppointment extends CheckRatingAppointmentEvent {
  final int appointmentId;

  OnCheckRatingAppointment(this.appointmentId);
}
