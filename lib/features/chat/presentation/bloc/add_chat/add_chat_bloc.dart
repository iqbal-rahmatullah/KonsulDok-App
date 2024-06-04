import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/chat/domain/usecase/add_chat.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_message_byid.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/message_by_id/message_by_id_bloc.dart';
import 'package:konsul_dok/init_dependencies.dart';
import 'package:meta/meta.dart';

part 'add_chat_event.dart';
part 'add_chat_state.dart';

class AddChatBloc extends Bloc<AddChatEvent, AddChatState> {
  final AddChatCase addChat;

  AddChatBloc({required this.addChat}) : super(AddChatInitial()) {
    on<AddChatEvent>((event, emit) {
      emit(AddChatLoading());
    });
    on<AddChat>(
      (event, emit) async {
        final params = AddChatParams(
          message: event.message,
          sender_id: event.sender_id,
          receive_id: event.receive_id,
        );
        final response = await addChat(params);

        await response.fold(
          (failure) async => emit(AddChatError(message: failure.message)),
          (success) async {
            emit(AddChatSuccess(chatId: success));
          },
        );
      },
    );
  }
}
