import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/chat_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: MySpacing.paddingInsetPage.copyWith(top: 20),
        child: Column(
          children: [
            chatWidget(),
            chatWidget(),
          ],
        ),
      ),
    );
  }
}
