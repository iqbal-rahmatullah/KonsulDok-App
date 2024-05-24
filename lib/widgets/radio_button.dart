import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class RadioButton extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onChanged;

  const RadioButton({Key? key, required this.gender, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jenis kelamin",
          style: MyTextStyle.deskripsi.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                onChanged('pria');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Radio(
                    activeColor: Colors.blue, // Ganti dengan warna yang sesuai
                    value: 'pria',
                    groupValue: gender,
                    onChanged: (value) {
                      onChanged(value.toString());
                    },
                  ),
                  const Text("Laki-laki", style: MyTextStyle.deskripsi),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onChanged('wanita');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Radio(
                    activeColor: Colors.blue, // Ganti dengan warna yang sesuai
                    value: 'wanita',
                    groupValue: gender,
                    onChanged: (value) {
                      onChanged(value.toString());
                    },
                  ),
                  const Text("Perempuan", style: MyTextStyle.deskripsi),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
