import 'package:hive/hive.dart';

abstract class AuthLocalDataSource {
  Future<void> addToken(String token);
  void removeToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<String> box;

  AuthLocalDataSourceImpl({required this.box});

  @override
  Future<void> addToken(String token) async {
    await box.put('token', token);
  }

  @override
  void removeToken() {
    box.clear();
  }
}
