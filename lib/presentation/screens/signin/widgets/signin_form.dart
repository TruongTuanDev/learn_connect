import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import file xử lý API

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isLoading = false;

  final AuthService authService = AuthService(); // 🔥 Sử dụng AuthService

  Future<void> _login() async {
    setState(() => isLoading = true);

    final String user = userController.text.trim();
    final String password = passwordController.text.trim();

    if (user.isEmpty || password.isEmpty) {
      _showMessage("Vui lòng nhập tên đăng nhập và mật khẩu!");
      setState(() => isLoading = false);
      return;
    }

    final result = await authService.login(user, password);

    if (result['success']) {
      _showMessage("Đăng nhập thành công!");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", result['data']['accessToken']);
      Navigator.pushNamed(context, AppRoutes.home,arguments: {
        'user': result['data']['user'],
        'userInfor': result['data']['userInfor']
      });
      print("Token nhận được: ${result['data']['accessToken']}");
    } else {
      _showMessage(result['message']);
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: userController,
          decoration: InputDecoration(
            labelText: 'Tên đăng nhập',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.account_circle),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => isPasswordVisible = !isPasswordVisible),
              child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (value) => setState(() => rememberMe = value ?? false),
              activeColor: Colors.black,
            ),
            Text('Nhớ đăng nhập'),
            Spacer(),
            TextButton(onPressed: () {}, child: Text('Quên mật khẩu?')),
          ],
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: isLoading ? null : _login,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}
