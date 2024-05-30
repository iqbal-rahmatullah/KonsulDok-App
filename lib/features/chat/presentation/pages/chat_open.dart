import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/home_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/socket/socket_config.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/chat_pages/other_chat.dart';
import 'package:konsul_dok/widgets/chat_pages/own_chat.dart';
import 'package:konsul_dok/widgets/text_field.dart';

class ChatOpenPage extends StatefulWidget {
  final List<ChatDetail> chat;
  final String receipeintName;
  const ChatOpenPage(
      {super.key, required this.chat, required this.receipeintName});

  @override
  State<ChatOpenPage> createState() => _ChatOpenPageState();
}

class _ChatOpenPageState extends State<ChatOpenPage> {
  TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void sendMessage() {
    final SocketConfig socketConfig = SocketConfig(context: context);
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;
    BlocProvider.of<ChatBloc>(context).add(AddChatEvent(
      message: chatController.text,
      sender_id: authState.user.id,
      receive_id: widget.chat[0].chatId,
    ));

    socketConfig.handleSendMessage(
        message: chatController.text,
        receiverId: authState.user.id,
        senderId: widget.chat[0].chatId);
    chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/doctor-example.jpg"),
            ),
            const SizedBox(width: 10),
            Text(
              widget.receipeintName,
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
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatDetailLoaded) {
                    setState(() {
                      widget.chat.clear();
                      widget.chat.addAll(state.chatDetails);
                    });
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        widget.chat.length,
                        (index) =>
                            widget.chat[index].senderId == authState.user.id
                                ? ownChat(
                                    context: context,
                                    message: widget.chat[index].message,
                                  )
                                : otherChat(
                                    context: context,
                                    message: widget.chat[index].message,
                                  ),
                      ),
                    ),
                  );
                },
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
