part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<Chat> chats;

  ChatLoaded({required this.chats});
}

final class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}

final class ChatAdded extends ChatState {
  final List<Chat> chats;

  ChatAdded({required this.chats});
}

final class ChatDetailLoaded extends ChatState {
  final List<ChatDetail> chatDetails;

  ChatDetailLoaded({required this.chatDetails});
}
