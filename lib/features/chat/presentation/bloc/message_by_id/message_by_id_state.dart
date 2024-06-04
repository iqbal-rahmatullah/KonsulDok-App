part of 'message_by_id_bloc.dart';

@immutable
sealed class MessageByIdState {}

final class MessageByIdInitial extends MessageByIdState {}

final class MessageByIdLoading extends MessageByIdState {}

final class MessageByIdLoaded extends MessageByIdState {
  final List<ChatDetail> chatDetails;

  MessageByIdLoaded({required this.chatDetails});
}

final class MessageByIdError extends MessageByIdState {
  final String message;

  MessageByIdError({required this.message});
}
