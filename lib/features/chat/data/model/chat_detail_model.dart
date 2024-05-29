import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';

class ChatDetailModel extends ChatDetail {
  ChatDetailModel(
      {required super.id,
      required super.chatId,
      required super.senderId,
      required super.message});

  factory ChatDetailModel.fromJson(Map<String, dynamic> json) {
    return ChatDetailModel(
      id: json['id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      message: json['message'],
    );
  }
}
