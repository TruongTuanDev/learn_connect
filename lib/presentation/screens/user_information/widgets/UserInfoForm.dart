import 'package:flutter/material.dart';
class UserInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(label: 'Tên đầy đủ'),
        CustomTextField(label: 'Biệt danh'),
        CustomTextField(label: 'Ngày sinh', icon: Icons.calendar_today),
        CustomTextField(label: 'Email', icon: Icons.email),
        PhoneField(),
        GenderDropdown(),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;

  CustomTextField({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/512px-Flag_of_Vietnam.svg.png',
                  width: 24,
                  height: 16,
                ),
              ),
              Text('(+84)  ', style: TextStyle(fontSize: 16)),
            ],
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: ['Nam', 'Nữ', 'Khác'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
        hint: Text('Giới tính'),
      ),
    );
  }
}
