import 'package:flutter/material.dart';
import 'CulturePreferencePage.dart';

class LanguageInfoScreen extends StatefulWidget {

  @override
  _LanguageInfoScreenState createState() => _LanguageInfoScreenState();
}

class _LanguageInfoScreenState extends State<LanguageInfoScreen> {
  dynamic args;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    args = ModalRoute.of(context)?.settings.arguments;

    print("in cái args xem:+ $args" );

    // Chỉ set khi chưa có formData (tránh overwrite khi rebuild)

  }
  String nativeLanguage = 'Tiếng Việt';

  final List<Map<String, String>> targetLanguages = [
    {'name': 'Tiếng Anh', 'flag': '🇬🇧'},
    {'name': 'Tiếng Trung', 'flag': '🇨🇳'},
    {'name': 'Tiếng Nhật', 'flag': '🇯🇵'},
    {'name': 'Tiếng Hàn', 'flag': '🇰🇷'},
  ];

  Map<String, String> selectedLanguages = {};
  List<String> goals = [];
  List<String> learningGoals = ['Giao tiếp', 'Thi lấy chứng chỉ', 'Du học', 'Công việc'];
  String dailyTime = '30 phút';
  List<String> levels = ['Sơ cấp', 'Trung cấp', 'Cao cấp'];

  void toggleLanguage(String language) {
    setState(() {
      if (selectedLanguages.containsKey(language)) {
        selectedLanguages.remove(language);
      } else {
        selectedLanguages[language] = 'Sơ cấp';
      }
    });
  }

  Widget buildSelectableBox(String text, bool isSelected, VoidCallback onTap, {String? emoji}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? Colors.blueAccent : Colors.grey.shade300, width: 1.5),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 6, offset: Offset(0, 2))]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (emoji != null) Text(emoji, style: TextStyle(fontSize: 18)),
            if (emoji != null) SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.blueAccent : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridLanguages() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: targetLanguages.map((lang) {
        final isSelected = selectedLanguages.containsKey(lang['name']);
        return buildSelectableBox(
          lang['name']!,
          isSelected,
              () => toggleLanguage(lang['name']!),
          emoji: lang['flag'],
        );
      }).toList(),
    );
  }

  Widget buildGrid(List<String> items, List<String> selectedList, void Function(String) onTap) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: items.map((item) {
        final isSelected = selectedList.contains(item);
        return buildSelectableBox(item, isSelected, () => onTap(item));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thông tin học ngôn ngữ'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ngôn ngữ mẹ đẻ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButton<String>(
                value: nativeLanguage,
                isExpanded: true,
                items: ['Tiếng Anh', 'Tiếng Việt', 'Khác'].map((lang) {
                  return DropdownMenuItem(child: Text(lang), value: lang);
                }).toList(),
                onChanged: (value) => setState(() => nativeLanguage = value!),
              ),
              SizedBox(height: 20),

              Text("Ngôn ngữ muốn học", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              buildGridLanguages(),
              SizedBox(height: 16),

              if (selectedLanguages.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedLanguages.keys.map((lang) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Trình độ - $lang", style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade50,
                          ),
                          child: DropdownButton<String>(
                            value: selectedLanguages[lang],
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down),
                            items: levels.map((lvl) {
                              return DropdownMenuItem(child: Text(lvl), value: lvl);
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLanguages[lang] = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),

              SizedBox(height: 24),
              Text("Mục tiêu học tập", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              buildGrid(learningGoals, goals, (goal) {
                setState(() {
                  goals.contains(goal) ? goals.remove(goal) : goals.add(goal);
                });
              }),
              SizedBox(height: 20),

              Text("Thời gian học mỗi ngày", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              DropdownButton<String>(
                value: dailyTime,
                isExpanded: true,
                items: ['15 phút', '30 phút', '60 phút'].map((time) {
                  return DropdownMenuItem(child: Text(time), value: time);
                }).toList(),
                onChanged: (value) => setState(() => dailyTime = value!),
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final combinedData = {
                      'id_user' : args['id_user'],
                      'username': args['username'],
                      'email': args['email'],
                      'nativeLanguage': nativeLanguage,
                      'selectedLanguages': selectedLanguages,
                      'goals': goals,
                      'dailyTime': dailyTime,
                    };
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CulturePreferencesScreen(formData: combinedData),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text('Tiếp tục', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
