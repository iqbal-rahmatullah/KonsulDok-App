part of 'add_chat_bloc.dart';

@immutable
sealed class AddChatEvent {}

class AddChat extends AddChatEvent {
  final String message;
  final int sender_id;
  final int receive_id;

  AddChat(
      {required this.message,
      required this.sender_id,
      required this.receive_id});
}
