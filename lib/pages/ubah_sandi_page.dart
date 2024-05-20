import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class UbahSandiPage extends StatefulWidget {
  const UbahSandiPage({Key? key}) : super(key: key);

  @override
  _UbahSandiPageState createState() => _UbahSandiPageState();
}

class _UbahSandiPageState extends State<UbahSandiPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ubah Sandi',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColor.blackAppbar),
          onPressed: () {
            Navigator.pop(context);
          },
   ),
),
      body: Stack(
        children: [
          Padding(
            padding: MySpacing.paddingPage,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _emailController,
                    label: 'Email',
                    isPassword: false,
                  ),
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _passwordController,
                    label: 'Sandi',
                    isPassword: true,
                    isVisible: _isPasswordVisible,
                    onVisibilityChanged: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _confirmPasswordController,
                    label: 'Konfirmasi Sandi',
                    isPassword: true,
                    isVisible: _isConfirmPasswordVisible,
                    onVisibilityChanged: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 100.0), 
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: MyColor.gradientBiru,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sandi Telah Diperbarui')),
                      );
                    }
                  },
                  child: Text(
                    'Simpan Perubahan',
                    style: MyTextStyle.subheder.copyWith(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onVisibilityChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword && !isVisible,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none,
            ),
            fillColor: MyColor.putihForm,
            filled: true,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: onVisibilityChanged,
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter value';
            }
            return null;
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UbahSandiPage(),
  ));
}
