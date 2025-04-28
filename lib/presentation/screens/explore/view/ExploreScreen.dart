import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/app_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/culture_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/connection_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/custom_search_delegate.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExploreScreen> {
  final List<String> languageApps = [
    'Duolingo', 'Babbel', 'Memrise', 'HelloTalk', 'Tandem'
  ];

  final List<String> cultures = [
    'Văn hóa Nhật Bản', 'Văn hóa Hàn Quốc', 'Văn hóa Pháp', 'Văn hóa Tây Ban Nha', 'Văn hóa Ấn Độ'
  ];

  final List<String> connectionTopics = [
    'Tìm bạn học tiếng Nhật', 'Giao lưu với người bản xứ Hàn Quốc', 'Thực hành tiếng Pháp', 'Chia sẻ kinh nghiệm học tiếng Tây Ban Nha'
  ];

  String searchQuery = '';

  // Hàm lọc tìm kiếm
  List<String> filterItems(List<String> items) {
    return items.where((item) => item.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khám Phá Ứng Dụng & Văn Hóa'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ứng Dụng Học Ngoại Ngữ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: languageApps.length,
                itemBuilder: (context, index) {
                  return AppCard(appName: languageApps[index], imagePath: 'assets/language_app_${index + 1}.png');
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Khám Phá Văn Hóa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cultures.length,
                itemBuilder: (context, index) {
                  return CultureCard(culture: cultures[index], imagePath: 'assets/culture_${index + 1}.png');
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kết Nối Bạn Bè Quốc Tế',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: connectionTopics.length,
                itemBuilder: (context, index) {
                  return ConnectionCard(connectionTopic: connectionTopics[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
