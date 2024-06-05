import 'package:konsul_dok/features/doctor/data/model/doctor_model.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/favorite/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  FavoriteModel({
    required super.id,
    required super.patientId,
    required super.doctorId,
    required super.doctor,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      doctor: DoctorModel.fromJson(json['doctor']),
    );
  }
}
