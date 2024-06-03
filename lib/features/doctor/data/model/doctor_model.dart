import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.kategori,
    required super.description,
    required super.price,
    required super.hospitalName,
    required super.photoProfile,
    required super.experience,
    required super.name,
    super.averageRating,
    super.totalRating,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      kategori: json['categori'],
      description: json['description'],
      price: json['price'],
      hospitalName: json['hospital_name'],
      photoProfile: json['photo_profile'],
      experience: json['experience'],
      name: json['user']['name'],
      averageRating: json['averageRatting'] ?? 0,
      totalRating: json['countRating'] ?? 0,
    );
  }
}
