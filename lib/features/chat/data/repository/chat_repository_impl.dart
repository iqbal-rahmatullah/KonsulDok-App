import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Chat>>> getChats() async {
    try {
      final result = await remoteDataSource.getChats();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> addChat(
      {required String message,
      required int sender_id,
      required int receive_id}) async {
    try {
      final response = await remoteDataSource.addChat(
        message: message,
        sender_id: sender_id,
        receive_id: receive_id,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Chat>> getChatDetail(int doctorId) async {
    try {
      final result = await remoteDataSource.getChatDetail(doctorId);
      return Right(result);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatDetail>>> getMessageByIdChat(
      int chatId) async {
    try {
      final result = await remoteDataSource.getMessageByIdChat(chatId);
      return Right(result);
    } on NotFoundException catch (_) {
      return const Right([]);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> openChat({required int receiverId}) async {
    try {
      final result = await remoteDataSource.openChat(receiverId: receiverId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
