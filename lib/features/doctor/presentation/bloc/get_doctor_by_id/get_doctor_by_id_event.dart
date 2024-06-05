part of 'get_doctor_by_id_bloc.dart';

@immutable
sealed class GetDoctorByIdEvent {}

final class OnGetDoctorGetById extends GetDoctorByIdEvent {
  final String id;

  OnGetDoctorGetById({required this.id});
}
