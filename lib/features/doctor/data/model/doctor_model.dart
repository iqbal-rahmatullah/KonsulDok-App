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
    required super.rating,
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
      rating: json['rating'],
    );
  }
}
