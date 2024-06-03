import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConfig {
  late IO.Socket socket;
  final String url = "http://10.252.133.88:3000";
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
      context.read<ChatBloc>().add(GetChatsEvent());
    });
  }

  void handleSendMessage(
      {required String message,
      required int receiverId,
      required int senderId}) {
    socket.emit('message', {
      "message": message,
      "sender_id": senderId,
      "receiver_id": receiverId,
    });
  }
}
