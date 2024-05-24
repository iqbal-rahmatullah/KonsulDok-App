import 'package:konsul_dok/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.password,
    required super.name,
    required super.phone,
    required super.age,
    required super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['no_hp'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
