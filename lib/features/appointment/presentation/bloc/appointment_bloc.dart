import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/create_appointment.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final CreateAppointment _createAppointment;

  AppointmentBloc({
    required CreateAppointment createAppointment,
  })  : _createAppointment = createAppointment,
        super(AppointmentInitial()) {
    on<AppointmentEvent>((event, emit) {
      emit(AppointmentLoading());
    });
    on<CreateAppointmentEvent>(_onCreateAppointmentEvent);
  }

  void _onCreateAppointmentEvent(event, emit) async {
    final result = await _createAppointment(
      CreateAppointmentParams(
        patientId: event.patientId,
        doctorId: event.doctorId,
        date: event.date,
        time: event.time,
      ),
    );
    result.fold(
      (l) => emit(AppointmentError(l.message)),
      (r) => emit(
        AppointmentSuccess(r),
      ),
    );
  }
}
