import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/rating/domain/usecase/check_rating_appointment_case.dart';
import 'package:meta/meta.dart';

part 'check_rating_appointment_event.dart';
part 'check_rating_appointment_state.dart';

class CheckRatingAppointmentBloc
    extends Bloc<CheckRatingAppointmentEvent, CheckRatingAppointmentState> {
  final CheckRatingAppointmentCase checkRatingAppointmentCase;

  CheckRatingAppointmentBloc({required this.checkRatingAppointmentCase})
      : super(CheckRatingAppointmentInitial()) {
    on<CheckRatingAppointmentEvent>((event, emit) {
      emit(CheckRatingAppointmentLoading());
    });
    on<OnCheckRatingAppointment>((event, emit) async {
      final response = await checkRatingAppointmentCase(event.appointmentId);
      response.fold(
        (l) => emit(CheckRatingAppointmentError(l.message)),
        (r) => emit(CheckRatingAppointmentSuccess(r)),
      );
    });
  }
}
