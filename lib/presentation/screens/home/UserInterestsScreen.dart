import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserInterestsScreen(),
    );
  }
}

class UserInterestsScreen extends StatefulWidget {
  @override
  _UserInterestsScreenState createState() => _UserInterestsScreenState();
}

class _UserInterestsScreenState extends State<UserInterestsScreen> {
  List<String> interests = [
    'Âm nhạc', 'Phim ảnh', 'Du lịch', 'Thể thao', 'Nấu ăn', 'Chụp ảnh',
    'Game', 'Khám phá', 'Ngoại ngữ', 'Lập trình', 'Khởi nghiệp', 'Khác'
  ];

  Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text('Sở thích', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  return buildInterestChip(interests[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: ['Tùy chọn thêm'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {},
              hint: Text(''),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tiếp tục', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInterestChip(String label) {
    bool isSelected = selectedInterests.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedInterests.remove(label) : selectedInterests.add(label);
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
