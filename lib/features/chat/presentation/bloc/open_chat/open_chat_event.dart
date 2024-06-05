part of 'open_chat_bloc.dart';

@immutable
sealed class OpenChatEvent {}

final class OnOpenChat extends OpenChatEvent {
  final int receiverId;

  OnOpenChat({required this.receiverId});
}
