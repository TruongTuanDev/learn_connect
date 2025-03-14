import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/flashcard_model.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardWidget({
    Key? key,
    required this.flashcard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: CardWidget(text: flashcard.front, isFront: true),
        back: CardWidget(text: flashcard.back, isFront: false),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final String text;
  final bool isFront;

  const CardWidget({Key? key, required this.text, required this.isFront}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setPitch(1.0);
    flutterTts.awaitSpeakCompletion(true);
  }

  void _playSound() async {
    if (!isPlaying) {
      setState(() => isPlaying = true);
      await flutterTts.speak(widget.text);
      setState(() => isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String word = "", type = "", pronunciation = "";
    if (widget.isFront) {
      RegExp regex = RegExp(r"^(.*?) \((.*?)\) /(.*)/");
      Match? match = regex.firstMatch(widget.text);
      if (match != null) {
        word = match.group(1) ?? "";
        type = match.group(2) ?? "";
        pronunciation = "/${match.group(3) ?? ""}/";
      } else {
        word = widget.text;
      }
    }

    return Container(
      width: 400,
      height: 350,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.pink[100]!, Colors.pink[200]!]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: widget.isFront ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: widget.isFront
                  ? [
                Text(word, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 10),
                Text(type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87)),
                SizedBox(height: 10),
                Text(pronunciation, style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black54)),
              ]
                  : [
                Text("Định nghĩa:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 5),
                Text(widget.text.split("Ví dụ:")[0].trim(),
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(height: 10),
                Text("Ví dụ:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 5),
                Text("• ${widget.text.split("Ví dụ:").length > 1 ? widget.text.split("Ví dụ:")[1].trim() : ""}",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _playSound,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPlaying ? Colors.grey[300] : Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Icon(Icons.volume_up, size: 28, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
