import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/add_chat/add_chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/all_chat/chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/message_by_id/message_by_id_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/socket/bloc/socket_bloc.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/chat_pages/other_chat.dart';
import 'package:konsul_dok/widgets/chat_pages/own_chat.dart';
import 'package:konsul_dok/widgets/text_field.dart';

class ChatOpenPage extends StatefulWidget {
  final Doctor? doctor;
  final User? user;
  final int idChat;

  const ChatOpenPage({super.key, this.doctor, this.user, required this.idChat});

  @override
  State<ChatOpenPage> createState() => _ChatOpenPageState();
}

class _ChatOpenPageState extends State<ChatOpenPage> {
  TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    context
        .read<MessageByIdBloc>()
        .add(GetMessageByIdEvent(chatId: widget.idChat));

    super.initState();
  }

  void sendMessage() {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

    BlocProvider.of<AddChatBloc>(context).add(AddChat(
      message: chatController.text,
      sender_id: authState.user.id,
      receive_id: widget.doctor != null ? widget.doctor!.id : widget.user!.id,
    ));

    context.read<SocketBloc>().add(
          SockedSendMessage(
            message: chatController.text,
            receiverId:
                widget.doctor != null ? widget.doctor!.id : widget.user!.id,
            senderId: authState.user.id,
            chatId: widget.idChat,
          ),
        );

    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: (widget.doctor != null)
                  ? NetworkImage(
                      "${widget.doctor!.photoProfile}&s=${widget.doctor!.id}",
                    )
                  : const AssetImage("assets/images/patient_profile.png")
                      as ImageProvider,
            ),
            const SizedBox(width: 10),
            Text(
              (widget.doctor != null) ? widget.doctor!.name : widget.user!.name,
              style: MyTextStyle.subheder.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Padding(
        padding: MySpacing.paddingPage.copyWith(bottom: 20, top: 0),
        child: Column(
          children: [
            Expanded(
              child: BlocListener<AddChatBloc, AddChatState>(
                listener: (context, state) {
                  if (state is AddChatSuccess) {
                    context
                        .read<MessageByIdBloc>()
                        .add(GetMessageByIdEvent(chatId: state.chatId));
                    context.read<ChatBloc>().add(GetChatsEvent());
                  }
                },
                child: BlocBuilder<MessageByIdBloc, MessageByIdState>(
                  builder: (context, state) {
                    if (state is MessageByIdLoaded) {
                      return SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            state.chatDetails.length,
                            (index) => state.chatDetails[index].senderId ==
                                    authState.user.id
                                ? ownChat(
                                    context: context,
                                    message: state.chatDetails[index].message,
                                    image: (widget.doctor != null)
                                        ? const AssetImage(
                                                "assets/images/patient_profile.png")
                                            as ImageProvider
                                        : NetworkImage(
                                            "https://source.unsplash.com/random/?doctor&s=${authState.user.id}",
                                          ),
                                  )
                                : otherChat(
                                    context: context,
                                    message: state.chatDetails[index].message,
                                    image: (widget.doctor != null)
                                        ? NetworkImage(
                                            "${widget.doctor!.photoProfile}&s=${widget.doctor!.id}",
                                          )
                                        : const AssetImage(
                                                "assets/images/patient_profile.png")
                                            as ImageProvider,
                                  ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Flexible(
                  child: textField(
                    hintText: "Masukkan pesan anda",
                    controller: chatController,
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: const Icon(
                    Icons.send,
                    color: MyColor.biruIndicator,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
