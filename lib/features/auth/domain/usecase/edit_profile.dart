import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class EditProfileCase extends UseCase<User, EditProfileParams> {
  final AuthRepository repository;

  EditProfileCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(EditProfileParams params) async {
    return await repository.editProfile(
      name: params.name,
      phone: params.phone,
      age: params.age,
      email: params.email,
      gender: params.gender,
    );
  }
}

class EditProfileParams {
  final String name;
  final String phone;
  final int age;
  final String email;
  final String gender;

  EditProfileParams(
      {required this.name,
      required this.phone,
      required this.age,
      required this.email,
      required this.gender});
}
