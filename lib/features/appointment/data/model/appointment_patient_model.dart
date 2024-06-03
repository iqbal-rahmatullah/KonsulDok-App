import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/auth/data/models/user_model.dart';
import 'package:konsul_dok/features/doctor/data/model/doctor_model.dart';

class AppointmentPatientModel extends AppointmentPatient {
  AppointmentPatientModel(
      {required super.id,
      required super.date,
      required super.time,
      required super.patientId,
      required super.doctorId,
      required super.status,
      required super.doctor,
      required super.patient});

  factory AppointmentPatientModel.fromJson(Map<String, dynamic> json) {
    return AppointmentPatientModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      status: json['status'],
      doctor: DoctorModel.fromJson(json['doctor']),
      patient: UserModel.fromJson(json['patient']),
    );
  }
}
