import 'package:flutter/material.dart';

class UserInfoForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormDataChanged;

  UserInfoForm({required this.onFormDataChanged});

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final fullNameController = TextEditingController();
  final nicknameController = TextEditingController();
  final birthDateController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedGender;

  void updateFormData() {
    widget.onFormDataChanged({
      'fullName': fullNameController.text,
      'nickname': nicknameController.text,
      'birthDate': birthDateController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'gender': selectedGender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Tên đầy đủ',
          controller: fullNameController,
          onChanged: (_) => updateFormData(),
        ),
        CustomTextField(
          label: 'Biệt danh',
          controller: nicknameController,
          onChanged: (_) => updateFormData(),
        ),
        CustomTextField(
          label: 'Ngày sinh',
          controller: birthDateController,
          icon: Icons.calendar_today,
          onChanged: (_) => updateFormData(),
        ),
        CustomTextField(
          label: 'Email',
          controller: emailController,
          icon: Icons.email,
          onChanged: (_) => updateFormData(),
        ),
        PhoneField(controller: phoneController, onChanged: (_) => updateFormData()),
        GenderDropdown(
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
            updateFormData();
          },
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final Function(String)? onChanged;

  CustomTextField({required this.label, this.icon, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
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
  final TextEditingController controller;
  final Function(String)? onChanged;

  PhoneField({required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
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
  final Function(String?) onChanged;

  GenderDropdown({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        items: ['Nam', 'Nữ', 'Khác']
            .map((gender) => DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        ))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Giới tính',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
