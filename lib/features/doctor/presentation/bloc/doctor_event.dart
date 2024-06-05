part of 'doctor_bloc.dart';

@immutable
sealed class DoctorEvent {}

final class DoctorGetCategory extends DoctorEvent {
  final String name;

  DoctorGetCategory({required this.name});
}
