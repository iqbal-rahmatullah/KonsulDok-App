part of 'get_chat_doctor_bloc.dart';

@immutable
sealed class GetChatDoctorState {}

final class GetChatDoctorInitial extends GetChatDoctorState {}

final class GetChatDoctorLoading extends GetChatDoctorState {}

final class GetChatDoctorLoaded extends GetChatDoctorState {
  final Chat chats;

  GetChatDoctorLoaded({required this.chats});
}

final class GetChatDoctorError extends GetChatDoctorState {
  final String message;

  GetChatDoctorError({required this.message});
}

final class GetChatDoctorNotFound extends GetChatDoctorState {
  final String message;

  GetChatDoctorNotFound({required this.message});
}
