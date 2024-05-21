import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _practicePlaceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    _practicePlaceController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profil',
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
                  _buildProfileImage(),
                  SizedBox(height: 32.0), // Tambahkan jarak lebih besar di sini
                  _buildEditField(
                    controller: _nameController,
                    label: 'Nama',
                  ),
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _specializationController,
                    label: 'Spesialis',
                  ),
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _practicePlaceController,
                    label: 'Tempat Praktik',
                  ),
                  SizedBox(height: 16.0),
                  _buildEditField(
                    controller: _cityController,
                    label: 'Kota',
                  ),
                  SizedBox(height: 100.0), // Added space to prevent overlapping with the button
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the profile
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil Telah Diperbarui')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: MyColor.gradientBiru,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
                    child: Text(
                      'Simpan Perubahan',
                      style: MyTextStyle.subheder.copyWith(color: Colors.white),
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

  Widget _buildProfileImage() {
    return Column(
      children: [
        SizedBox(height: 8), // Tambahkan jarak di sini
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Ganti dengan gambar profil yang sesuai
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Tambahkan logika untuk mengubah gambar profil
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColor.biru,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEditField({
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0), // Geser teks lebih ke kanan
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0), // Rounded corners
              borderSide: BorderSide.none, // Remove border
            ),
            fillColor: MyColor.putihForm,
            filled: true,
            suffixIcon: IconButton(
              icon: Icon(Icons.edit, color: MyColor.biru), // Ubah warna icon menjadi biru
              onPressed: () {
                // Add any action you want when the edit icon is pressed
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Harap diisi terlebih dahulu';
            }
            return null;
          },
        ),
      ],
    );
  }
}
