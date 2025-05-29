import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ResultsPage extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onResetQuiz;
  final VoidCallback onNewQuiz;
  final VoidCallback onReviewQuestions;

  const ResultsPage({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.onResetQuiz,
    required this.onNewQuiz,
    required this.onReviewQuestions,
  }) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    super.initState();
    sendScoreToTelegram(widget.score, widget.totalQuestions);
  }

  Future<void> sendScoreToTelegram(int score, int totalQuestions) async {
    const String token = '7760835572:AAFSgw9jJ6D16zx0q2kzWFmZgDpUfSkrp6g'; // <-- Thay bằng token của bạn
    const String chatId = '1920122481'; // <-- Thay bằng chat_id của bạn
    final String userName = "Trương Văn Tuấn";
    final String formattedTime = DateFormat('HH:mm:ss - dd/MM/yyyy').format(DateTime.now());
    final String message = '''
╔═══════════════════════════╗
   🎉 Chúc mừng, $userName!
╚═══════════════════════════╝

📝 Kết quả bài kiểm tra:
📊 Số điểm: $score / $totalQuestions
📈 Tỉ lệ đúng: ${(score / totalQuestions * 100).toStringAsFixed(0)}%

🕒 Thời gian hoàn thành: $formattedTime

🏆 Tiếp tục phát huy nhé!
''';

    final url = Uri.parse('https://api.telegram.org/bot$token/sendMessage');

    try {
      await http.post(url, body: {
        'chat_id': chatId,
        'text': message,
      });
    } catch (e) {
      debugPrint('Failed to send message to Telegram: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final score = widget.score;
    final totalQuestions = widget.totalQuestions;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 8,
            shadowColor: Colors.blue.shade200.withOpacity(0.6),
            child: Container(
              padding: const EdgeInsets.all(28.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: score >= totalQuestions / 2
                      ? [Colors.blue.shade100, Colors.blue.shade50]
                      : [Colors.amber.shade100, Colors.amber.shade50],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    'Hoàn thành bài kiểm tra!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade600, Colors.blue.shade400],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.6),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$score/$totalQuestions',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Điểm của bạn: ${(score / totalQuestions * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: widget.onResetQuiz,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Thử lại'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: widget.onNewQuiz,
                        icon: const Icon(Icons.settings),
                        label: const Text('Bài kiểm tra mới'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: widget.onReviewQuestions,
            icon: const Icon(Icons.question_answer),
            label: const Text('Xem lại bài làm'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ],
      ),
    );
  }
}
