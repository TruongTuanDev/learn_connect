import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/flashcard_model.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/model/search_flash_card_model.dart';

class FlashcardWidget extends StatelessWidget {
  final FlashCardItem flashcard;

  const FlashcardWidget({Key? key, required this.flashcard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: CardWidget(
          word: flashcard.word,
          type: flashcard.type,
          phonetic: flashcard.phonetic,
          textToSpeak: flashcard.word,
          isFront: true,
        ),
        back: CardWidget(
          definition: flashcard.definition,
          exampleEn: flashcard.example_en,
          exampleVi: flashcard.example_vi,
          textToSpeak: flashcard.definition,
          isFront: false,
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final bool isFront;
  final String textToSpeak;

  // For front side
  final String? word;
  final String? type;
  final String? phonetic;

  // For back side
  final String? definition;
  final String? exampleEn;
  final String? exampleVi;

  const CardWidget({
    Key? key,
    required this.isFront,
    required this.textToSpeak,
    this.word,
    this.type,
    this.phonetic,
    this.definition,
    this.exampleEn,
    this.exampleVi,
  }) : super(key: key);

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
      await flutterTts.speak(widget.textToSpeak);
      setState(() => isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 300,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[100]!, Colors.pink[200]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: widget.isFront ? _buildFrontSide() : _buildBackSide(),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _playSound,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPlaying ? Colors.grey[300] : Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const Icon(Icons.volume_up, size: 28, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontSide() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.word ?? '',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            widget.type ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.phonetic ?? '',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackSide() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Định nghĩa:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            widget.definition ?? '',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "Ví dụ:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          if ((widget.exampleEn ?? '').isNotEmpty)
            Text(
              "• ${widget.exampleEn}",
              style: const TextStyle(fontSize: 16),
            ),
          if ((widget.exampleVi ?? '').isNotEmpty)
            Text(
              "• (${widget.exampleVi})",
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
