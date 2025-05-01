import 'package:flutter/material.dart';
import 'package:learn_connect/data/models/UserInfor.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/userInfor_service.dart';

class CulturePreferencesScreen extends StatefulWidget {
  final Map<String, dynamic> formData;

  CulturePreferencesScreen({required this.formData});

  @override
  _CulturePreferencesScreenState createState() => _CulturePreferencesScreenState();
}

class _CulturePreferencesScreenState extends State<CulturePreferencesScreen> {
  List<String> selectedCountries = [];
  List<String> selectedPreferences = [];

  final List<String> countries = [
    'Hàn Quốc', 'Nhật Bản', 'Việt Nam', 'Trung Quốc',
    'Mỹ', 'Pháp', 'Thái Lan', 'Anh', 'Ý', 'Ấn Độ'
  ];

  final Map<String, IconData> countryIcons = {
    'Hàn Quốc': Icons.flag,
    'Nhật Bản': Icons.sunny,
    'Việt Nam': Icons.star,
    'Trung Quốc': Icons.account_balance,
    'Mỹ': Icons.public,
    'Pháp': Icons.wine_bar,
    'Thái Lan': Icons.temple_buddhist,
    'Anh': Icons.castle,
    'Ý': Icons.local_pizza,
    'Ấn Độ': Icons.spa,
  };

  final List<String> preferences = [
    'Âm nhạc', 'Phim ảnh', 'Lịch sử',
    'Ẩm thực', 'Nghệ thuật', 'Du lịch',
    'Thời trang', 'Văn học', 'Tập quán',
    'Lễ hội', 'Ngôn ngữ', 'Khác'
  ];

  final Map<String, IconData> preferenceIcons = {
    'Âm nhạc': Icons.music_note,
    'Phim ảnh': Icons.movie,
    'Lịch sử': Icons.history_edu,
    'Ẩm thực': Icons.restaurant,
    'Nghệ thuật': Icons.palette,
    'Du lịch': Icons.flight_takeoff,
    'Thời trang': Icons.checkroom,
    'Văn học': Icons.menu_book,
    'Tập quán': Icons.people_alt,
    'Lễ hội': Icons.celebration,
    'Ngôn ngữ': Icons.language,
    'Khác': Icons.category,
  };

  Widget buildGridBox(List<String> items, List<String> selectedList, Map<String, IconData> iconMap) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: items.map((item) {
        final isSelected = selectedList.contains(item);
        return GestureDetector(
          onTap: () {
            setState(() {
              isSelected ? selectedList.remove(item) : selectedList.add(item);
            });
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Icon(iconMap[item], color: isSelected ? Colors.blue : Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildSection(String title, String subtitle, List<String> items, List<String> selectedList, Map<String, IconData> icons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        SizedBox(height: 12),
        buildGridBox(items, selectedList, icons),
        SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Sở thích văn hoá'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSection(
                      "Quốc gia/văn hoá quan tâm",
                      "Để cung cấp nội dung và kết nối với người có cùng sở thích",
                      countries,
                      selectedCountries,
                      countryIcons,
                    ),
                    buildSection(
                      "Sở thích văn hoá",
                      "Để cá nhân hóa nội dung khám phá văn hoá",
                      preferences,
                      selectedPreferences,
                      preferenceIcons,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final fullFormData = {
                    ...widget.formData,
                    'interestedCountries': selectedCountries,
                    'culturalPreferences': selectedPreferences,
                  };
                  print("username í là: " + widget.formData['username']);
                  UserInfo user = UserInfo(
                    id_user: widget.formData['id_user'] as String,
                    username: widget.formData['username'] as String,
                    fullName: "",
                    nickname: "",
                    birthDate: "",
                    email: widget.formData['email'],
                    phoneCode: "",
                    gender: "",
                    nativeLanguage: widget.formData['nativeLanguage'],
                    targetLanguages: Map<String, String>.from(widget.formData['selectedLanguages'] ?? {}),
                    learningGoals: List<String>.from(widget.formData['goals'] ?? []),
                    dailyTime: widget.formData['dailyTime'],
                    interestedCountries: selectedCountries,
                    culturalPreferences: selectedPreferences,
                    imageBytes: "",
                  );
                  UserInforService().updateInfor(user);
                  Navigator.pushNamed(context, AppRoutes.signin);
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                label: Text('Hoàn tất', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
