import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FAQ",
          style: MyTextStyle.header,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                ItemFaq(
                    question: "Apa itu aplikasi TemuDok?",
                    answer:
                        "Aplikasi TemuDok adalah sebuah aplikasi yang memudahkan proses penjadwalan antara pasien dan penyedia layanan kesehatan. Aplikasi ini menawarkan berbagai fitur seperti pencarian dokter berdasarkan poliklinik, peninjauan jadwal dokter yang tersedia, dan mengatur jadwal untuk konsultasi. "),
                ItemFaq(
                    question:
                        "Apakah saya bisa berkonsultasi dengan dokter kapan saja?",
                    answer:
                        "Aplikasi TemuDok adalah sebuah aplikasi yang memudahkan proses penjadwalan antara pasien dan penyedia layanan kesehatan. Aplikasi ini menawarkan berbagai fitur seperti pencarian dokter berdasarkan poliklinik, peninjauan jadwal dokter yang tersedia, dan mengatur jadwal untuk konsultasi. "),
                ItemFaq(
                    question:
                        "Apakah ada biaya untuk berkonsultasi dengan dokter?",
                    answer:
                        "Aplikasi TemuDok adalah sebuah aplikasi yang memudahkan proses penjadwalan antara pasien dan penyedia layanan kesehatan. Aplikasi ini menawarkan berbagai fitur seperti pencarian dokter berdasarkan poliklinik, peninjauan jadwal dokter yang tersedia, dan mengatur jadwal untuk konsultasi. "),
                ItemFaq(
                    question: "Bagaimana cara membuat janji temu dengan dokter",
                    answer:
                        "Aplikasi TemuDok adalah sebuah aplikasi yang memudahkan proses penjadwalan antara pasien dan penyedia layanan kesehatan. Aplikasi ini menawarkan berbagai fitur seperti pencarian dokter berdasarkan poliklinik, peninjauan jadwal dokter yang tersedia, dan mengatur jadwal untuk konsultasi. "),
                ItemFaq(
                    question: "Apakah data pribadi saya aman",
                    answer:
                        "Aplikasi TemuDok adalah sebuah aplikasi yang memudahkan proses penjadwalan antara pasien dan penyedia layanan kesehatan. Aplikasi ini menawarkan berbagai fitur seperti pencarian dokter berdasarkan poliklinik, peninjauan jadwal dokter yang tersedia, dan mengatur jadwal untuk konsultasi. "),
              ],
            )),
      ),
    );
  }
}

class ItemFaq extends StatelessWidget {
  final String question;
  final String answer;
  const ItemFaq({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: MyTextStyle.subheder,
        ),
        iconColor: Colors.blue,
        collapsedIconColor: Colors.blue,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          )
        ],
      ),
    );
  }
}
