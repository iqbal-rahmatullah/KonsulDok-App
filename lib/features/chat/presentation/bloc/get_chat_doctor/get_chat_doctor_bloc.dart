import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_detail_chat.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:meta/meta.dart';

part 'get_chat_doctor_event.dart';
part 'get_chat_doctor_state.dart';

class GetChatDoctorBloc extends Bloc<GetChatDoctorEvent, GetChatDoctorState> {
  final GetDetailChatCase getDetailChat;

  GetChatDoctorBloc({required this.getDetailChat})
      : super(GetChatDoctorInitial()) {
    on<GetChatDoctorEvent>((event, emit) {
      emit(GetChatDoctorLoading());
    });

    on<GetChatDoctorAction>(
      (event, emit) async {
        final result = await getDetailChat(GetDetailChatParams(
          idDoctor: event.doctorId,
        ));
        result.fold(
          (failure) => failure is NotFoundFailure
              ? emit(GetChatDoctorNotFound(message: failure.message))
              : emit(
                  GetChatDoctorError(message: failure.message),
                ),
          (chats) => emit(GetChatDoctorLoaded(chats: chats)),
        );
      },
    );
  }
}
