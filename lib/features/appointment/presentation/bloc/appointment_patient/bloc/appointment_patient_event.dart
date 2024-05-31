part of 'appointment_patient_bloc.dart';

@immutable
sealed class AppointmentPatientEvent {}

final class GetAppointmentPatientEvent extends AppointmentPatientEvent {}

final class GetAppointmentDoctorEvent extends AppointmentPatientEvent {}
