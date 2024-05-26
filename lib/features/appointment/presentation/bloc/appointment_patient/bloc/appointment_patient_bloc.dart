import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/get_appointment_patient.dart';
import 'package:meta/meta.dart';

part 'appointment_patient_event.dart';
part 'appointment_patient_state.dart';

class AppointmentPatientBloc
    extends Bloc<AppointmentPatientEvent, AppointmentPatientState> {
  final GetAppointmentPatient _getAppointmentPatient;
  AppointmentPatientBloc({required GetAppointmentPatient getAppointmentPatient})
      : _getAppointmentPatient = getAppointmentPatient,
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
  }
}
