import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/profile/widgets/profile_avatar.dart';
class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa hồ sơ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileAvatar(),
            SizedBox(height: 20),
            _buildTextField('Tên đầy đủ'),
            _buildTextField('Biệt danh'),
            _buildTextField('Ngày sinh', icon: Icons.calendar_today),
            _buildTextField('Email', icon: Icons.email),
            _buildPhoneField(),
            _buildDropdownField('Giới Tính', ['Nam', 'Nữ', 'Khác']),
            _buildTextField('Sinh Viên'),
            SizedBox(height: 20),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
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
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (value) {},
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
        onPressed: () {},
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
