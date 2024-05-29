import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/text_field.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatOpenPage extends StatefulWidget {
  const ChatOpenPage({super.key});

  @override
  State<ChatOpenPage> createState() => _ChatOpenPageState();
}

class _ChatOpenPageState extends State<ChatOpenPage> {
  late IO.Socket socket;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io('http://10.252.135.5:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('connected');
      socket.emit('signin', 42);

      socket.on("message", (msg) {
        print(msg);
      });
    });
  }

  void sendMessage() {
    socket.emit('message', {
      "message": controller.text,
      "sender_id": 1,
      "receiver_id": 2,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/doctor-example.jpg",
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Column(
              children: [
                Text(
                  "Dr. Uchiha Santoso",
                  style: MyTextStyle.subheder.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Terakhir dilihat pada 19.20",
                  style: MyTextStyle.deskripsi.copyWith(
                    color: MyColor.abuText,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: MySpacing.paddingPage.copyWith(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: MyColor.biruIndicator,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Text(
                    "cuci muka dan gosok gigi. selanjutnya rutin makan nasi",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.putih,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/doctor-example.jpg",
                  ),
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            textField(controller: controller),
            ElevatedButton(
                onPressed: () {
                  sendMessage();
                },
                child: const Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
