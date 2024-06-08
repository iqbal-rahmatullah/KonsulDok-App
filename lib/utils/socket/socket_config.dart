import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/all_chat/chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/message_by_id/message_by_id_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConfig {
  late IO.Socket socket;
  final String url = "http://192.168.190.118:3000";
  final BuildContext context;

  SocketConfig({required this.context});

  void connect(int userId) {
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('connected');
      socket.emit('signin', userId);
    });

    socket.on("message", (msg) {
      Future.delayed(const Duration(milliseconds: 500), () {
        context.read<MessageByIdBloc>().add(GetMessageByIdEvent(chatId: 1));
        context.read<ChatBloc>().add(GetChatsEvent());
      });
    });
  }

  void handleSendMessage(
      {required String message,
      required int chatId,
      required int receiverId,
      required int senderId}) {
    socket.emit('message', {
      "message": message,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "chatId": chatId,
    });
  }
}
