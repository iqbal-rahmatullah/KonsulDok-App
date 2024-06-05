part of 'update_status_appointment_bloc.dart';

@immutable
sealed class UpdateStatusAppointmentState {}

final class UpdateStatusAppointmentInitial
    extends UpdateStatusAppointmentState {}

final class UpdateStatusAppointmentLoading
    extends UpdateStatusAppointmentState {}

final class UpdateStatusAppointmentSuccess
    extends UpdateStatusAppointmentState {
  UpdateStatusAppointmentSuccess();
}

final class UpdateStatusAppointmentError extends UpdateStatusAppointmentState {
  final String message;

  UpdateStatusAppointmentError(this.message);
}
