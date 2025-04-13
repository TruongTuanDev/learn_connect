import 'package:flutter/material.dart';

@immutable
class FlashCardItem {
  final String id;
  final String word;
  final String type;
  final String phonetic;
  final String definition;
  final String example_en;
  final String example_vi;
  final String audioUrl;

  const FlashCardItem({
    required this.id,
    required this.word,
    required this.type,
    required this.phonetic,
    required this.definition,
    required this.example_en,
    required this.example_vi,
    required this.audioUrl,
  });

  factory FlashCardItem.fromJson(Map<String, dynamic> json) {
    final requiredKeys = [
      'id',
      'word',
      'type',
      'phonetic',
      'definition',
      'example_en',
      'example_vi',
      'audioUrl',
    ];

    for (var key in requiredKeys) {
      if (!json.containsKey(key)) {
        print("❌ Thiếu key '$key' trong json: $json");
        throw const FormatException('❌ Dữ liệu không hợp lệ khi parse FlashCardItem');
      }
    }

    return FlashCardItem(
      id: json['id'] as String,
      word: json['word'] as String,
      type: json['type'] as String,
      phonetic: json['phonetic'] as String,
      definition: json['definition'] as String,
      example_en: json['example_en'] as String,
      example_vi: json['example_vi'] as String,
      audioUrl: json['audioUrl'] as String,
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'word': word,
    'type': type,
    'phonetic': phonetic,
    'definition': definition,
    'example_en': example_en,
    'example_vi': example_vi,
    'audioUrl': audioUrl,
  };
}
