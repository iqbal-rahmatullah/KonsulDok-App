part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetChatsEvent extends ChatEvent {}

class AddChatEvent extends ChatEvent {
  final String message;
  final int sender_id;
  final int receive_id;

  AddChatEvent(
      {required this.message,
      required this.sender_id,
      required this.receive_id});
}

class GetDetailChatEvent extends ChatEvent {
  final int doctorId;

  GetDetailChatEvent({required this.doctorId});
}

class GetMessageByIdEvent extends ChatEvent {
  final int chatId;

  GetMessageByIdEvent({required this.chatId});
}
