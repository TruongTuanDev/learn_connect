import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/config/app_config.dart';
import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/search_ai/PartnerFinderApp.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/providers.dart';
import '../../search_ai/provider/partners_provider.dart';

class SignInForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final matchedPartnersProvider = StateProvider<List<dynamic>>((ref) => []);

  final AuthService authService = AuthService();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;

    final username = _userController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar('Vui lòng nhập đầy đủ thông tin');
      return;
    }

    setState(() => _isLoading = true);


    try {
      final result = await authService.login(username, password);

      if (result['success']) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', result['data']['accessToken']);
        AppConfig.userId = result['data']['id'];
        print("Id user "+ AppConfig.userId);
        // final List<dynamic> matchedPartners = result['data']['matchedLanguagePartners'];
        final matchedPartners = result['data']['matchedLanguagePartners'];

        // Gán vào provider
        ref.read(userPartnersProvider.notifier).setPartners(
            matchedPartners
        );
      Navigator.pushNamed(context, AppRoutes.home,arguments: {
        'user': result['data']['userInfo'],
        'userInfor': result['data']['userInfo']
      });
        }


    } catch (e) {
      _showSnackBar('Lỗi kết nối: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _userController,
            decoration: InputDecoration(
              labelText: 'Tên đăng nhập',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value ?? false),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Text('Ghi nhớ đăng nhập'),
              Spacer(),
              TextButton(
                onPressed: () {

                },
                child: Text('Quên mật khẩu?'),
              ),
            ],
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blueAccent,
              ),
            )
                : Text(
              'ĐĂNG NHẬP',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
