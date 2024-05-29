import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/chat_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatState = context.read<ChatBloc>().state;

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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatLoaded) {
            return Padding(
              padding: MySpacing.paddingInsetPage.copyWith(top: 20),
              child: Column(
                  children: List.generate(
                state.chats.length,
                (index) => chatWidget(
                  context: context,
                  doctor: state.chats[index].doctor,
                  messages: state.chats[index].chat,
                ),
              )),
            );
          } else if (state is ChatError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
