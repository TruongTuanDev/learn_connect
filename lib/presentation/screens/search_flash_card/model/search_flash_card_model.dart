import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_connect/services/flashcard_service.dart';

@immutable
class FlashCard {
  final String id;
  final bool enabled;
  final String status;
  final String title;
  final String description;
  final String language;
  final String createdAt;
  final String updatedAt;

  const FlashCard({
    required this.id,
    required this.enabled,
    required this.status,
    required this.title,
    required this.description,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'enabled': enabled,
    'status': status,
    'title': title,
    'description': description,
    'language': language,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id') && json.containsKey('title')) {
      return FlashCard(
        id: json['id'] as String,
        enabled: json['enabled'] as bool? ?? false,
        status: json['status'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        language: json['language'] as String? ?? '',
        createdAt: json['created_at'] as String? ?? '',
        updatedAt: json['updated_at'] as String? ?? '',
      );
    } else {
      throw const FormatException('❌ Dữ liệu không hợp lệ khi parse FlashCard');
    }
  }
}

class FlashCardModel {
  final dio = Dio();

  Future<List<FlashCard>> fetchFlashCards() async {
    final FlashcardService flashcardService = FlashcardService();
    final result = await flashcardService.getTopics();

    if (result['success'] == true) {
      final List<dynamic> jsonList = result['data'];

      return jsonList
          .map((item) => FlashCard.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(result['message'] ?? '❌ Không thể tải danh sách chủ đề');
    }
  }
}
