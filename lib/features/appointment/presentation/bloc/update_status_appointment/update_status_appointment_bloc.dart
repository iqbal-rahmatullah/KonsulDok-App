import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/update_status_appointment_case.dart';
import 'package:meta/meta.dart';

part 'update_status_appointment_event.dart';
part 'update_status_appointment_state.dart';

class UpdateStatusAppointmentBloc
    extends Bloc<UpdateStatusAppointmentEvent, UpdateStatusAppointmentState> {
  final UpdateStatusAppointmentCase updateStatusAppointmentCase;

  UpdateStatusAppointmentBloc({required this.updateStatusAppointmentCase})
      : super(UpdateStatusAppointmentInitial()) {
    on<UpdateStatusAppointmentEvent>((event, emit) {
      emit(UpdateStatusAppointmentLoading());
    });
    on<OnUpdateStatusAppointment>((event, emit) async {
      final response = await updateStatusAppointmentCase(
          UpdateStatusAppointmentParams(
              appointmentId: event.appointmentId, status: event.status));
      response.fold((l) => emit(UpdateStatusAppointmentError(l.message)),
          (r) => emit(UpdateStatusAppointmentSuccess()));
    });
  }
}
