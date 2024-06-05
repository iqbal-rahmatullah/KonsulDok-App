import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/chat/data/model/chat_detail_model.dart';
import 'package:konsul_dok/features/chat/data/model/chat_model.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<int> addChat({
    required String message,
    required int sender_id,
    required int receive_id,
  });
  Future<ChatModel> getChatDetail(int doctorId);
  Future<List<ChatDetail>> getMessageByIdChat(int chatId);
  Future<int> openChat({
    required int receiverId,
  });
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
        chats.add(ChatModel.fromJson(item));
      }

      return chats;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        return [];
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> addChat(
      {required String message,
      required int sender_id,
      required int receive_id}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.post(
        "${ApiEnv.apiUrl}/chat/add",
        data: {
          "message": message,
          "sender_id": sender_id,
          "receive_id": receive_id,
        },
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      return response.data['data']['chat_id'];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ChatModel> getChatDetail(int doctorId) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.get(
        '${ApiEnv.apiUrl}/chat/detail/$doctorId',
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      return ChatModel.fromJson(response.data['data']);
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw NotFoundException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ChatDetail>> getMessageByIdChat(int chatId) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.get(
        '${ApiEnv.apiUrl}/chat/message/$chatId',
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      List<ChatDetailModel> chats = [];
      for (var item in response.data['data']) {
        chats.add(ChatDetailModel.fromJson(item));
      }

      return chats;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        return [];
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> openChat({required int receiverId}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.post(
        '${ApiEnv.apiUrl}/chat/open-chat',
        data: {
          'receive_id': receiverId,
        },
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      return response.data['data']['id'];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
