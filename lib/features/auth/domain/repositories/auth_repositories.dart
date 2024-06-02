import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> loginAccount({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> registerAccount({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
  });

  void saveToken({required String token});

  Future<Either<Failure, User>> getUser();

  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<Either<Failure, User>> editProfile({
    required String name,
    required String phone,
    required int age,
    required String email,
    required String gender,
  });
}
