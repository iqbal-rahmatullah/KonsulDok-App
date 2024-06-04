part of 'message_by_id_bloc.dart';

@immutable
sealed class MessageByIdEvent {}

class GetMessageByIdEvent extends MessageByIdEvent {
  final int chatId;

  GetMessageByIdEvent({required this.chatId});
}
