part of 'get_chat_doctor_bloc.dart';

@immutable
sealed class GetChatDoctorEvent {}

class GetChatDoctorAction extends GetChatDoctorEvent {
  final int doctorId;

  GetChatDoctorAction({required this.doctorId});
}
