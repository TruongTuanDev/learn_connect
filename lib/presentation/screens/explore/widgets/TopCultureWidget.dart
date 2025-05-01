import 'package:flutter/material.dart';

class TopCultureWidget extends StatelessWidget {
  final List<CountryCulture> cultures = [
    CountryCulture(rank: 1, name: "Nhật Bản", score: 4867, flag: "🇯🇵"),
    CountryCulture(rank: 2, name: "Hàn Quốc", score: 4050, flag: "🇰🇷"),
    CountryCulture(rank: 3, name: "Việt Nam", score: 3853, flag: "🇻🇳"),
    CountryCulture(rank: 4, name: "Pháp", score: 3298, flag: "🇫🇷"),
    CountryCulture(rank: 5, name: "Ý", score: 3061, flag: "🇮🇹"),
    CountryCulture(rank: 6, name: "Tây Ban Nha", score: 3001, flag: "🇪🇸"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Top 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTopPosition(cultures[1], second: true), // hạng 2
              buildTopPosition(cultures[0], first: true),  // hạng 1
              buildTopPosition(cultures[2], third: true),  // hạng 3
            ],
          ),
          SizedBox(height: 30),
          // Các hạng từ 4 trở đi
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cultures.length - 3,
            itemBuilder: (context, index) {
              final culture = cultures[index + 3];
              return buildCultureTile(culture);
            },
          ),
        ],
      ),
    );
  }

  Widget buildTopPosition(CountryCulture culture, {bool first = false, bool second = false, bool third = false}) {
    double avatarRadius = first ? 55 : 40;
    double topMargin = first ? 0 : 40; // Top 1 cao hơn rõ rệt
    double iconSize = first ? 36 : 28;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${culture.rank}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: EdgeInsets.only(top: topMargin),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: Text(
                  culture.flag,
                  style: TextStyle(fontSize: avatarRadius),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Icon(
                Icons.emoji_events,
                color: first
                    ? Colors.amber
                    : second
                    ? Colors.grey
                    : Colors.brown,
                size: iconSize,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          culture.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "${culture.score} điểm",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildCultureTile(CountryCulture culture) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            culture.flag,
            style: TextStyle(fontSize: 24),
          ),
        ),
        title: Text("${culture.rank}. ${culture.name}"),
        trailing: Text(
          "${culture.score} điểm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CountryCulture {
  final int rank;
  final String name;
  final int score;
  final String flag;

  CountryCulture({
    required this.rank,
    required this.name,
    required this.score,
    required this.flag,
  });
}
