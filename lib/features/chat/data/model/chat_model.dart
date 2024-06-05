import 'package:konsul_dok/features/auth/data/models/user_model.dart';
import 'package:konsul_dok/features/chat/data/model/chat_detail_model.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/doctor/data/model/doctor_model.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.id,
    required super.chat,
    required super.doctor,
    required super.patient,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      chat: json['chat'] == null || (json['chat'] as List).isEmpty
          ? <ChatDetailModel>[]
          : (json['chat'] as List)
              .map((item) => ChatDetailModel.fromJson(item))
              .toList(),
      doctor: DoctorModel.fromJson(json['doctor']),
      patient: UserModel.fromJson(json['patient']),
    );
  }
}
