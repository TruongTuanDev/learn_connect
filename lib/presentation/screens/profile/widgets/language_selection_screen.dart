import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'Vietnamese (VN)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn Ngôn Ngữ')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Vietnamese (VN)'),
            trailing: selectedLanguage == 'Vietnamese (VN)' ? Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              setState(() {
                selectedLanguage = 'Vietnamese (VN)';
              });
              Navigator.pop(context, selectedLanguage);
            },
          ),
          ListTile(
            title: Text('English (EN)'),
            trailing: selectedLanguage == 'English (EN)' ? Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              setState(() {
                selectedLanguage = 'English (EN)';
              });
              Navigator.pop(context, selectedLanguage);
            },
          ),
        ],
      ),
    );
  }
}
