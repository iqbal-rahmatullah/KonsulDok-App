import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/get_appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/get_detail_appointment_doctor.dart';

part 'appointment_patient_event.dart';
part 'appointment_patient_state.dart';

class AppointmentPatientBloc
    extends Bloc<AppointmentPatientEvent, AppointmentPatientState> {
  final GetAppointmentPatient _getAppointmentPatient;
  final GetAppointmentDoctor _getAppointmentDoctor;
  AppointmentPatientBloc(
      {required GetAppointmentPatient getAppointmentPatient,
      required GetAppointmentDoctor getAppointmentDoctor})
      : _getAppointmentPatient = getAppointmentPatient,
        _getAppointmentDoctor = getAppointmentDoctor,
        super(AppointmentPatientInitial()) {
    on<AppointmentPatientEvent>((event, emit) {
      emit(AppointmentPatientLoading());
    });
    on<GetAppointmentPatientEvent>((event, emit) async {
      final result = await _getAppointmentPatient(event.id);
      result.fold(
        (failure) => emit(AppointmentPatientError(message: failure.message)),
        (appointments) =>
            emit(AppointmentPatientLoaded(appointments: appointments)),
      );
    });
    on<GetAppointmentDoctorEvent>((event, emit) async {
      final result = await _getAppointmentDoctor(event.id);
      result.fold(
        (failure) => emit(AppointmentPatientError(message: failure.message)),
        (appointments) =>
            emit(AppointmentPatientLoaded(appointments: appointments)),
      );
    });
  }
}
