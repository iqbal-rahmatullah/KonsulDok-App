part of 'check_rating_appointment_bloc.dart';

@immutable
sealed class CheckRatingAppointmentState {}

final class CheckRatingAppointmentInitial extends CheckRatingAppointmentState {}

final class CheckRatingAppointmentLoading extends CheckRatingAppointmentState {}

final class CheckRatingAppointmentSuccess extends CheckRatingAppointmentState {
  final bool isRated;

  CheckRatingAppointmentSuccess(this.isRated);
}

final class CheckRatingAppointmentError extends CheckRatingAppointmentState {
  final String message;

  CheckRatingAppointmentError(this.message);
}
