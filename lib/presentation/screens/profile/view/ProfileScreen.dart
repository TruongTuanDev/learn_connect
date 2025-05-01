import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/profile/widgets/profile_avatar.dart';
import 'package:learn_connect/presentation/screens/profile/widgets/profile_option.dart';
import 'package:learn_connect/presentation/screens/profile/widgets/edit_profile_screen.dart';
import 'package:learn_connect/presentation/screens/profile/widgets/language_selection_screen.dart';
class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> userInfor;

  const ProfileScreen({
    Key? key,
    required this.user,
    required this.userInfor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("user và userInfor là:$user + $userInfor ");
    return Scaffold(
      appBar: AppBar(title: Text('Hồ sơ')),
      body: Column(
        children: [
          ProfileAvatar(imageBytesBase64:userInfor['imageBytes'] ),
          Text(userInfor['fullName'] ?? 'Tên người dùng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(userInfor['email'] ?? '', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileOption(title: 'Sửa hồ sơ', icon: Icons.edit, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        userInfor: userInfor,
                        user: userInfor,
                      ),
                    ),
                  );

                }),
                ProfileOption(title: 'Sở thích', icon: Icons.favorite, onTap: () {}),
                ProfileOption(title: 'Thông báo', icon: Icons.notifications, onTap: () {}),
                ProfileOption(title: 'Bảo mật', icon: Icons.lock, onTap: () {}),
                ProfileOption(
                  title: 'Ngôn ngữ',
                  subtitle: 'Vietnamese (VN)',
                  icon: Icons.language,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
                    );
                    if (result != null) {
                      // cập nhật giao diện nếu cần
                    }
                  },
                ),
                ProfileOption(title: 'Chế độ tối', icon: Icons.dark_mode, onTap: () {}),
                ProfileOption(title: 'Chính sách', icon: Icons.policy, onTap: () {}),
                ProfileOption(title: 'Hỗ trợ', icon: Icons.support, onTap: () {}),
                ProfileOption(title: 'Mời bạn bè', icon: Icons.group_add, onTap: () {}),
                ProfileOption(title: 'Đăng xuất', icon: Icons.logout, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
