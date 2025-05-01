import 'package:flutter/material.dart';

import '../data/friend_data.dart';
import '../view/FriendBubbleScreen.dart';

class ConnectionCard extends StatefulWidget {
  final String connectionTopic;
  final String imagePath; // Ảnh nền

  ConnectionCard({required this.connectionTopic, required this.imagePath});

  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                final country = friendsData.firstWhere(
                      (element) => element['country'] == widget.connectionTopic,
                );
                return FriendBubbleScreen(
                   // Nếu không có backgroundImage, trả về chuỗi rỗng
                  friends: List<Map<String, String>>.from(country['friends'] ?? []),
                  backgroundImagePath: country['backgroundImage'] ?? '',// Đảm bảo friends là List<Map<String, String>>
                );
              },
            ),
          );

        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.all(10),
          width: 180,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isHovered
                ? [BoxShadow(color: Colors.purpleAccent.withOpacity(0.5), blurRadius: 20, offset: Offset(0, 10))]
                : [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Ảnh nền RÕ, không bị làm mờ
                Image.network(
                  widget.imagePath,
                  fit: BoxFit.fill,
                ),
                // Vùng Glassmorphism chỉ nằm sau nội dung
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                // Nội dung icon + text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.1 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(Icons.people_alt_rounded, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.connectionTopic,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black87, blurRadius: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
    });
  }

  void _openDetails(BuildContext context, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(item),
          content: Text('Chi tiết về $item'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
