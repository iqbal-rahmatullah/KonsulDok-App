part of 'open_chat_bloc.dart';

@immutable
sealed class OpenChatState {}

final class OpenChatInitial extends OpenChatState {}

final class OpenChatLoading extends OpenChatState {}

final class OpenChatSuccess extends OpenChatState {
  final int idChat;

  OpenChatSuccess({required this.idChat});
}

final class OpenChatFailure extends OpenChatState {
  final String message;

  OpenChatFailure({required this.message});
}
