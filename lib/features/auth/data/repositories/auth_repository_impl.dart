import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:konsul_dok/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, String>> loginAccount({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerAccount({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
  }) async {
    try {
      final result = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        age: age,
        gender: gender,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  void saveToken({required String token}) {
    localDataSource.addToken(token);
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await remoteDataSource.getUser();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> editProfile(
      {required String name,
      required String phone,
      required int age,
      required String email,
      required String gender}) async {
    try {
      final response = await remoteDataSource.editProfile(
        name: name,
        phone: phone,
        age: age,
        email: email,
        gender: gender,
      );
      return right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
