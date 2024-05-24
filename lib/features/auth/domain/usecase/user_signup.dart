import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp({required this.repository});

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await repository.registerAccount(
      email: params.email,
      password: params.password,
      name: params.name,
      phone: params.phone,
      age: params.age,
      gender: params.gender,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  final String phone;
  final int age;
  final String gender;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
  });
}
