import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/search/coponents/search_box.dart';

class SearchScreen extends StatelessWidget {
  final List<String> flashcards = [
    "Cambridge Vocabulary for IELTS (20 units)",
    "Từ vựng tiếng Anh văn phòng",
    "Từ vựng tiếng Anh giao tiếp nâng cao",
    "Từ vựng tiếng Anh giao tiếp trung cấp",
    "Từ vựng Tiếng Anh giao tiếp cơ bản",
    "TOEFL Word List",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            "FLASHCARD",
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
            children: <Widget>[
              SearchBox(),
              SizedBox(height: 20),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                      ),
                    itemCount: flashcards.length,
                    itemBuilder: (context, index){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.pink[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(12.0),
                              child: Text(
                                flashcards[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
