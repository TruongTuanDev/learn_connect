import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/BannerSlider.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/app_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/culture_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/connection_card.dart';
import 'package:learn_connect/presentation/screens/explore/widgets/custom_search_delegate.dart';

import '../widgets/TopCultureWidget.dart';
import 'VanHoaPage.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExploreScreen> {
  final List<String> languageApps = [
    'Duolingo', 'Babbel', 'Memrise', 'HelloTalk', 'Tandem'
  ];

  final List<Map<String, String>> cultures = [
    {'name': 'Văn hóa Nhật Bản', 'imagePath': 'assets/culture/japan.png'},
    {'name': 'Văn hóa Hàn Quốc', 'imagePath': 'assets/culture/korea.png'},
    {'name': 'Văn hóa Pháp', 'imagePath': 'assets/culture/france.png'},
    {'name': 'Văn hóa Tây Ban Nha', 'imagePath': 'assets/culture/taybannha.png'},
    {'name': 'Văn hóa Ấn Độ', 'imagePath': 'assets/culture/ando.png'},
  ];
  final List<Map<String, String>> connectionTopics = [
    {'name': 'Nhật Bản', 'imagePath': 'assets/friend/japan.png'},
    {'name': 'Hàn Quốc', 'imagePath': 'assets/friend/korea.png'},
    {'name': 'Pháp', 'imagePath': 'assets/friend/ando.png'},
    {'name': 'Tây Ban Nha', 'imagePath': 'assets/friend/taybannha.png'},
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
        title: Text('Khám phá văn hóa',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia',)),
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
            Container(
              height: 200, // để đủ hiển thị cả slider và indicator dots
              child:BannerSlider(),
            ),


            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Khám Phá Văn Hóa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green,fontFamily: 'Georgia',),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cultures.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Hành động khi nhấn vào
                    },
                    child: CultureCard(
                      culture_name: cultures[index]['name']!,
                      imagePath: cultures[index]['imagePath']!,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kết Nối Bạn Bè Quốc Tế',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent,fontFamily: 'Georgia',),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: connectionTopics.length,
                itemBuilder: (context, index) {
                  return ConnectionCard(connectionTopic: connectionTopics[index]['name']!,
                      imagePath: connectionTopics[index]['imagePath']!);
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Bảng Xếp Hạng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue,fontFamily: 'Georgia',),
              ),
            ),
            Container(
                child: TopCultureWidget()
            ),
          ],
        ),
      ),
    );
  }
}
