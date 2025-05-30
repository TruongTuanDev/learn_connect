import 'dart:io';

import 'dart:typed_data'; // để dùng Uint8List
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_connect/presentation/screens/profile/widgets/profile_avatar.dart';

import '../../../../data/models/UserInfor.dart';
import '../../../../services/userInfor_service.dart';
import '../view/ProfileScreen.dart';
import 'package:image_picker/image_picker.dart';
class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userInfor;
  final Map<String, dynamic> user;
  EditProfileScreen({Key? key, required this.userInfor, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController nicknameController;
  late TextEditingController birthDateController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  File? _selectedImage;

  Uint8List? _imageBytes;


  final ImagePicker _picker = ImagePicker();
  String? selectedGender;

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController(text: widget.userInfor['fullName']);
    nicknameController = TextEditingController(text: widget.userInfor['nickname']);
    birthDateController = TextEditingController(text: widget.userInfor['birthDate']);
    emailController = TextEditingController(text: widget.userInfor['email']);
    phoneController = TextEditingController(text: widget.userInfor['phoneCode']); // Nếu có sẵn số thì truyền text:
    selectedGender = widget.userInfor['gender'];
    if (widget.userInfor['imageBytes'] != null && widget.userInfor['imageBytes'] is String) {
      _imageBytes = base64Decode(widget.userInfor['imageBytes']);
    }
  }
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }


  @override
  void dispose() {
    fullNameController.dispose();
    nicknameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    // _imageBytes.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    UserInfo user1 = UserInfo(
      id_user:  widget.userInfor['id_user'] as String,
      username: widget.userInfor['username'] as String,
      fullName: fullNameController.text,
      nickname: nicknameController.text,
      birthDate: birthDateController.text,
      email: emailController.text,
      phoneCode: phoneController.text,
      gender: selectedGender,
      nativeLanguage:  widget.userInfor['nativeLanguage'],
      targetLanguages: Map<String, String>.from(widget.userInfor['targetLanguages'] ?? {}),
      learningGoals: List<String>.from(widget.userInfor['goals'] ?? []),
      dailyTime: widget.userInfor['dailyTime'],
      interestedCountries:widget.userInfor['selectedCountries'] ,
      culturalPreferences:widget.userInfor['selectedPreferences'] ,
        imageBytes: _imageBytes != null
            ? base64Encode(_imageBytes!)
            : (widget.userInfor['imageBytes'] ?? ''),

    );
     await UserInforService().updatenewInfor(user1);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          user: widget.userInfor,
          userInfor: user1.toJson(), // Đây mới là dữ liệu đã cập nhật
        ),
      ),
    );



  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Sửa hồ sơ'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileAvatar(),
            SizedBox(height: 20),
            _buildTextField('Tên đầy đủ', controller: fullNameController),
            _buildTextField('Biệt danh', controller: nicknameController),
            _buildTextField('Ngày sinh', controller: birthDateController, icon: Icons.calendar_today),
            _buildTextField('Email', controller: emailController, icon: Icons.email),
            _buildPhoneField(),
            _buildDropdownField('Giới Tính', ['Nam', 'Nữ', '']),
            SizedBox(height: 20),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[300],
        backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : null,
        child: _imageBytes == null
            ? Icon(Icons.camera_alt, color: Colors.grey[600])
            : null,
      ),
    );
  }








  Widget _buildTextField(String label, {required TextEditingController controller, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Số điện thoại',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/flag_vn.png', width: 24),
                SizedBox(width: 8),
                Text('+84'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value;
          });
        },
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.blue,
        ),
        onPressed: _updateProfile,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cập nhật', style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
