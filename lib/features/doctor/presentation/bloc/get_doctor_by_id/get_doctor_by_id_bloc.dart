import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/domain/usecase/get_doctor_by_id.dart';
import 'package:meta/meta.dart';

part 'get_doctor_by_id_event.dart';
part 'get_doctor_by_id_state.dart';

class GetDoctorByIdBloc extends Bloc<GetDoctorByIdEvent, GetDoctorByIdState> {
  final GetDoctorById getDoctorById;

  GetDoctorByIdBloc({required this.getDoctorById})
      : super(GetDoctorByIdInitial()) {
    on<GetDoctorByIdEvent>((event, emit) {
      emit(GetDoctorByIdLoading());
    });
    on<OnGetDoctorGetById>(
      (event, emit) async {
        final result = await getDoctorById(GetDoctorByIdParams(id: event.id));
        result.fold(
            (failure) => emit(GetDoctorByIdError(message: failure.message)),
            (doctor) => emit(GetDoctorByIdLoaded(doctor: doctor)));
      },
    );
  }
}
