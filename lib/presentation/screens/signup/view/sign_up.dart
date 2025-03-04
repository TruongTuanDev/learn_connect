import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/signup/providers/auth_provider.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Đăng ký")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Tên")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Mật khẩu"), obscureText: true),
            SizedBox(height: 20),
            signUpState.status == SignUpStatus.loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                final model = SignUpModel(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
                signUpNotifier.signUp(model);
              },
              child: Text("Đăng ký"),
            ),
            if (signUpState.status == SignUpStatus.error)
              Text("Đăng ký thất bại!", style: TextStyle(color: Colors.red)),
            if (signUpState.status == SignUpStatus.success)
              Text("Đăng ký thành công!", style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
