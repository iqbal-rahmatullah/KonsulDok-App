import 'package:konsul_dok/features/rating/domain/entities/rating.dart';

class RatingModel extends Rating {
  RatingModel({
    required super.id,
    required super.doctorId,
    required super.appointmentId,
    required super.namePatient,
    required super.rating,
    required super.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      appointmentId: json['appointment_id'],
      namePatient: json['appointment']['patient']['name'],
      rating: json['rating'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
