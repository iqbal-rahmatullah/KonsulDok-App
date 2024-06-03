import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/domain/usecase/get_doctor_by_category.dart';
import 'package:konsul_dok/features/doctor/domain/usecase/get_doctor_by_id.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorByCategory _getDoctorByCategory;
  final GetDoctorById _getDoctorById;

  DoctorBloc(
      {required GetDoctorByCategory getDoctorByCategory,
      required GetDoctorById getDoctorById})
      : _getDoctorByCategory = getDoctorByCategory,
        _getDoctorById = getDoctorById,
        super(DoctorInitial()) {
    on<DoctorEvent>((event, emit) {
      emit(DoctorLoading());
    });
    on<DoctorGetCategory>(_doctorGetCategory);
    on<DoctorGetById>(
      (event, emit) async {
        final result = await _getDoctorById(GetDoctorByIdParams(id: event.id));
        result.fold((failure) => emit(DoctorError(message: failure.message)),
            (doctor) => emit(DoctorGetByIdLoaded(doctor: doctor)));
      },
    );
  }

  void _doctorGetCategory(event, emit) async {
    final result =
        await _getDoctorByCategory(GetDoctorByCategoryParams(name: event.name));

    result.fold((failure) => emit(DoctorError(message: failure.message)),
        (doctor) => emit(DoctorGetCategoryLoaded(doctors: doctor)));
  }
}
