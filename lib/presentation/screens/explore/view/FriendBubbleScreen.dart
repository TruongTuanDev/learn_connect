import 'dart:math';
import 'package:flutter/material.dart';

class FriendBubbleScreen extends StatefulWidget {
  final List<Map<String, String>> friends;
  final String backgroundImagePath;

  FriendBubbleScreen({
    required this.friends,
    required this.backgroundImagePath,
  });

  @override
  _FriendBubbleScreenState createState() => _FriendBubbleScreenState();
}

class _FriendBubbleScreenState extends State<FriendBubbleScreen> with SingleTickerProviderStateMixin {
  late AnimationController _emojiController;
  Map<String, String>? selectedFriend;
  bool isConnecting = false; // trạng thái kết nối cho animation nút

  @override
  void initState() {
    super.initState();
    _emojiController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
    selectedFriend = widget.friends.isNotEmpty ? widget.friends[0] : null;
  }

  @override
  void dispose() {
    _emojiController.dispose();
    super.dispose();
  }

  void _connect() async {
    setState(() {
      isConnecting = true;
    });
    await Future.delayed(Duration(seconds: 2)); // giả lập kết nối
    setState(() {
      isConnecting = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Connected to ${selectedFriend?['name'] ?? 'Friend'}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Nửa trên
          Stack(
            children: [
              Container(
                height: height * 0.45,
                width: double.infinity,
                child: Image.asset(
                  widget.backgroundImagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _emojiController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: EmojiPainter(_emojiController.value),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.friends.length,
                    itemBuilder: (context, index) {
                      final friend = widget.friends[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFriend = friend;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: friend['avatarUrl'] != null
                                    ? AssetImage(friend['avatarUrl']!)
                                    : null,
                                backgroundColor: Colors.pinkAccent,
                                child: friend['avatarUrl'] == null
                                    ? Text(
                                  friend['name']![0],
                                  style: TextStyle(fontSize: 24, color: Colors.white),
                                )
                                    : null,
                              ),
                              SizedBox(height: 4),
                              Text(
                                friend['name'] ?? 'Unknown',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),

          // Nửa dưới
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: selectedFriend != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: selectedFriend!['avatarUrl'] != null
                        ?AssetImage(selectedFriend!['avatarUrl']!)
                        : null,
                    backgroundColor: Colors.pinkAccent,
                    child: selectedFriend!['avatarUrl'] == null
                        ? Text(
                      selectedFriend!['name']![0],
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                        : null,
                  ),
                  SizedBox(height: 16),
                  Text(
                    selectedFriend!['name'] ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),

                  // Giới thiệu đẹp
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, color: Colors.lightBlueAccent),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            selectedFriend!['description'] ?? 'No description available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Nút Connect
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: isConnecting ? null : _connect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                      ),
                      child: isConnecting
                          ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                          : Text('Kết nối'),
                    ),
                  ),
                ],
              )
                  : Center(child: Text("No friend selected")),
            ),
          )
        ],
      ),
    );
  }
}

class EmojiPainter extends CustomPainter {
  final double progress;
  final List<String> emojis = ['😂', '❤️', '🎵', '🌸', '😊'];

  EmojiPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = Random(1234);

    for (int i = 0; i < emojis.length; i++) {
      final emoji = emojis[i];
      final x = random.nextDouble() * size.width;
      final y = size.height * (1.0 - ((progress + i * 0.2) % 1.0));
      final textPainter = TextPainter(
        text: TextSpan(text: emoji, style: TextStyle(fontSize: 24)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
