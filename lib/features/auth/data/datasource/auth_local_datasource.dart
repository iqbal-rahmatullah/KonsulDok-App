import 'package:hive/hive.dart';
import 'package:konsul_dok/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> addToken(String token);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<String> box;

  AuthLocalDataSourceImpl({required this.box});

  @override
  Future<void> addToken(String token) async {
    await box.clear();
    await box.add(token);
  }
}
