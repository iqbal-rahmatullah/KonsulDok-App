import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/appointment/domain/entities/clock_appointment.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/get_clock_appointment.dart';
import 'package:meta/meta.dart';

part 'clock_appointment_event.dart';
part 'clock_appointment_state.dart';

class ClockAppointmentBloc
    extends Bloc<ClockAppointmentEvent, ClockAppointmentState> {
  GetClockAppointmentCase getClockAppointment;

  ClockAppointmentBloc({required this.getClockAppointment})
      : super(ClockAppointmentInitial()) {
    on<ClockAppointmentEvent>((event, emit) {
      emit(ClockAppointmentLoading());
    });
    on<GetClockAppointmentEvent>((event, emit) async {
      final result = await getClockAppointment(GetClockAppointmentParams(
          doctorId: event.doctorId, date: event.date));
      result.fold(
        (failure) => emit(ClockAppointmentError(failure.message)),
        (clockAppointments) => emit(ClockAppointmentLoaded(clockAppointments)),
      );
    });
  }
}
