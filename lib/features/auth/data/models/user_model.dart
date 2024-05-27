import 'package:konsul_dok/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.password,
    required super.name,
    required super.phone,
    required super.age,
    required super.gender,
    required super.id,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['no_hp'],
      age: json['age'],
      gender: json['gender'],
      role: json['role'],
    );
  }
}
