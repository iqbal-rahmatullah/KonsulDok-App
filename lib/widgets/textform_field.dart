import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class TextForm extends StatefulWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final bool isObsecure;
  final bool isNumberOnly;
  final bool isSmall;

  const TextForm({
    Key? key,
    required this.hintText,
    required this.label,
    this.isObsecure = false,
    required this.controller,
    this.isNumberOnly = false,
    this.isSmall = false,
  }) : super(key: key);

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObsecure;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isSmall ? 100 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: MyTextStyle.deskripsi.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '${widget.label} tidak boleh kosong';
              }
              return null;
            },
            keyboardType: widget.isNumberOnly ? TextInputType.number : null,
            inputFormatters: widget.isNumberOnly
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            obscureText: _isObscure,
            decoration: InputDecoration(
              errorStyle: MyTextStyle.deskripsi.copyWith(color: Colors.red),
              hintText: widget.hintText,
              hintStyle: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
              fillColor: MyColor.putihForm,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              suffixIcon: widget.isObsecure
                  ? InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
            ),
            cursorColor: MyColor.hitam,
            style: MyTextStyle.deskripsi,
          ),
        ],
      ),
    );
  }
}
