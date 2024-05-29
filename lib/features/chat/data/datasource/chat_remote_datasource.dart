import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/chat/data/model/chat_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  final Box<String> box;

  ChatRemoteDataSourceImpl({required this.dio, required this.box});

  @override
  Future<List<ChatModel>> getChats() async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio
          .get(
            '${ApiEnv.apiUrl}/chat',
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));

      List<ChatModel> chats = [];

      for (var item in response.data['data']) {
        // print(item);
        chats.add(ChatModel.fromJson(item));
      }

      return chats;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
