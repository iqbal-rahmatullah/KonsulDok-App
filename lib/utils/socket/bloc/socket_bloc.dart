import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/socket/socket_config.dart';
import 'package:meta/meta.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final SocketConfig socketConfig;

  SocketBloc({required this.socketConfig}) : super(SocketInitial()) {
    on<SocketEvent>((event, emit) {});
    on<SocketConnect>((event, emit) {
      socketConfig.connect(event.userId);
      emit(SocketConnected());
    });
    on<SockedSendMessage>((event, emit) {
      socketConfig.handleSendMessage(
        message: event.message,
        receiverId: event.receiverId,
        senderId: event.senderId,
        chatId: event.chatId,
      );
    });
  }
}
