import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CallScreen(),
    );
  }
}

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút quay lại
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                ),
                const SizedBox(height: 20),
                // Tên người dùng
                const Text(
                  'Toàn lỏ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                // Trạng thái cuộc gọi
                const Text(
                  'Đang gọi...',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Phần các nút điều khiển cuộc gọi
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút tắt tiếng
                CallButton(
                  icon: Icons.mic_off,
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.black,
                  onPressed: () {
                    // Xử lý sự kiện khi tắt tiếng
                  },
                ),

                const SizedBox(width: 20),
                // Nút tắt bật camera
                CallButton(
                  icon: Icons.videocam_off,
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.black,
                  onPressed: () {
                    // Xử lý sự kiện khi chuyển camera
                  },
                ),

                const SizedBox(width: 20),
                // Nút camera/video
                CallButton(
                  icon: Icons.switch_camera,
                  backgroundColor: Colors.blue,
                  iconColor: Colors.white,
                  onPressed: () {
                    // Xử lý sự kiện khi chuyển camera
                  },
                ),

                const SizedBox(width: 20),
                // Nút kết thúc cuộc gọi
                CallButton(
                  icon: Icons.call_end,
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  onPressed: () {
                    // Xử lý sự kiện khi kết thúc cuộc gọi
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const CallButton({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: 28),
        onPressed: onPressed,
      ),
    );
  }
}
