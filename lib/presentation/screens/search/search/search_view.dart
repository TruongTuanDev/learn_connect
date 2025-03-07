import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/search/coponents/search_box.dart';

class SearchScreenApp extends StatelessWidget {
  const SearchScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> recentSearches = [
    "Cambridge Vocabulary for IELTS (20 units)",
    "Từ vựng tiếng Anh văn phòng",
    "Từ vựng tiếng Anh giao tiếp nâng cao",
    "Từ vựng tiếng Anh giao tiếp trung cấp",
    "Từ vựng Tiếng Anh giao tiếp cơ bản",
    "TOEFL Word List",
  ];

  void _removeSearchItem(int index) {
    setState(() {
      recentSearches.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: Colors.black,)
        ),
        title: Text(
          "SEARCH",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchBox(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gần đây",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              recentSearches[index],
                              style: TextStyle(fontSize: 14),
                            ),
                            IconButton(
                                onPressed: () => _removeSearchItem(index),
                                icon: Icon(Icons.close, color: Colors.black54,)
                            )
                          ],
                        );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
