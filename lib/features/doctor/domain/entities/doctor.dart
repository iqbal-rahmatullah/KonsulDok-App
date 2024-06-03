import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';

class Doctor {
  final int id;
  final String kategori;
  final String description;
  final int price;
  final String hospitalName;
  final String photoProfile;
  final String experience;
  final String name;
  final int? averageRating;
  final int? totalRating;

  Doctor({
    required this.id,
    required this.kategori,
    required this.description,
    required this.price,
    required this.hospitalName,
    required this.photoProfile,
    required this.experience,
    required this.name,
    this.averageRating,
    this.totalRating,
  });
}
