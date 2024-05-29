import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';

class Chat {
  final int id;
  final List<ChatDetail> chat;
  final Doctor doctor;
  final User patient;

  Chat({
    required this.id,
    required this.chat,
    required this.doctor,
    required this.patient,
  });
}
