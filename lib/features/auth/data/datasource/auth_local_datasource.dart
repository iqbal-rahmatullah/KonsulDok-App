import 'package:hive/hive.dart';

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
