import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_message_byid.dart';
import 'package:meta/meta.dart';

part 'message_by_id_event.dart';
part 'message_by_id_state.dart';

class MessageByIdBloc extends Bloc<MessageByIdEvent, MessageByIdState> {
  final GetMessageById getMessageById;

  MessageByIdBloc({required this.getMessageById})
      : super(MessageByIdInitial()) {
    on<MessageByIdEvent>((event, emit) {
      emit(MessageByIdLoading());
    });

    on<GetMessageByIdEvent>(
      (event, emit) async {
        final result = await getMessageById(GetMessageByIdParams(
          chatId: event.chatId,
        ));
        result.fold(
          (failure) => emit(MessageByIdError(message: failure.message)),
          (chats) => emit(MessageByIdLoaded(chatDetails: chats)),
        );
      },
    );
  }
}
