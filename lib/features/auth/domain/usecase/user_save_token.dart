import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';

class SaveToken {
  final AuthRepository repository;

  SaveToken({required this.repository});

  void call({required String token}) {
    repository.saveToken(token: token);
  }
}
