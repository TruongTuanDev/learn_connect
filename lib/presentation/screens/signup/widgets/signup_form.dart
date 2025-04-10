import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/auth_service.dart';
import 'package:learn_connect/data/models/UserModel.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool rememberMe = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Hàm tạo người dùng
  void createUser() {
    UserModel user = UserModel(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    AuthService().signup(user);
  }

  // Hàm đăng ký
  void _register() {
    if (_formKey.currentState!.validate()) {
      createUser();  // Gọi hàm tạo người dùng

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bắt đầu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Tạo tài khoản', style: TextStyle(fontSize: 16, color: Color(0xFF545454))),
          SizedBox(height: 20),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) => value!.isEmpty ? "Username không được để trống" : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) => value!.isEmpty ? "Email không được để trống" : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
              ),
            ),
            validator: (value) => value!.length < 6 ? "Mật khẩu ít nhất 6 ký tự" : null,
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: !isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Nhập lại mật khẩu',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
              ),
            ),
            validator: (value) => value != passwordController.text ? "Mật khẩu không khớp" : null,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (bool? value) => setState(() => rememberMe = value ?? false),
              ),
              Text('Đồng ý với chính sách yêu cầu'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _register();
              Navigator.pushNamed(context, AppRoutes.information);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                alignment: Alignment.center,

                children: [
                  Text(
                    'Đăng kí',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
