part of 'add_chat_bloc.dart';

@immutable
sealed class AddChatState {}

final class AddChatInitial extends AddChatState {}

final class AddChatLoading extends AddChatState {}

final class AddChatError extends AddChatState {
  final String message;

  AddChatError({required this.message});
}

final class AddChatSuccess extends AddChatState {
  final int chatId;

  AddChatSuccess({required this.chatId});
}
