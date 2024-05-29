class ChatDetail {
  final int id;
  final int chatId;
  final int senderId;
  final String message;

  ChatDetail(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.message});
}
