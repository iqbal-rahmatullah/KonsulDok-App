import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/chat_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(GetChatsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;
    context.read<ChatBloc>().add(GetChatsEvent());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chat',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: MyColor.putihForm),
              onPressed: () {},
              child: const Icon(
                Icons.search,
                color: MyColor.abuForm,
              ))
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatDetailLoaded) {
            context.read<ChatBloc>().add(GetChatsEvent());
          }
        },
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Padding(
              padding: MySpacing.paddingInsetPage.copyWith(top: 20),
              child: Column(
                  children: List.generate(
                state.chats.length,
                (index) => chatWidget(
                  context: context,
                  doctor: authState.user.role == 'patient'
                      ? state.chats[index].doctor
                      : null,
                  patient: authState.user.role == 'doctor'
                      ? state.chats[index].patient
                      : null,
                  messages: state.chats[index].chat,
                  idChat: state.chats[index].id,
                ),
              )),
            );
          } else if (state is ChatError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
