part of 'socket_bloc.dart';

@immutable
sealed class SocketEvent {}

class SocketConnect extends SocketEvent {
  final int userId;

  SocketConnect(this.userId);
}

class SockedSendMessage extends SocketEvent {
  final String message;
  final int receiverId;
  final int senderId;
  final int chatId;

  SockedSendMessage({
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.chatId,
  });
}
