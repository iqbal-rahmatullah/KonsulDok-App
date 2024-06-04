part of 'get_chat_doctor_bloc.dart';

@immutable
sealed class GetChatDoctorState {}

final class GetChatDoctorInitial extends GetChatDoctorState {}

final class GetChatDoctorLoading extends GetChatDoctorState {}

final class GetChatDoctorLoaded extends GetChatDoctorState {
  final List<ChatDetail> chatDetails;

  GetChatDoctorLoaded({required this.chatDetails});
}

final class GetChatDoctorError extends GetChatDoctorState {
  final String message;

  GetChatDoctorError({required this.message});
}
