import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class FlashCard{
  final String id;
  final String flash_card_type;

  const FlashCard({required this.id, required this.flash_card_type});

  //json dont have datetime type, change it to string
  Map<String, dynamic> toJson() => {'id' : id, 'flashCardType': flash_card_type};

  factory FlashCard.fromJson(Map<String, dynamic> json){
    return switch(json) {
      {'id' : String id, 'flashCardType' : String flash_card_type} => FlashCard(
        id: id,
        flash_card_type: flash_card_type
      ),
    _ => throw const FormatException('Failed to load search history')
    };
  }
}

class FlashCardModel{

  final List<FlashCard> _flashCard = [
    FlashCard(id: "1", flash_card_type: "Cambridge Vocabulary for IELTS (20 units)"),
    FlashCard(id: "2", flash_card_type:   "Từ vựng tiếng Anh văn phòng"),
    FlashCard(id: "3", flash_card_type: "Từ vựng tiếng Anh giao tiếp nâng cao"),
    FlashCard(id: "4", flash_card_type: "Từ vựng tiếng Anh giao tiếp trung cấp"),
    FlashCard(id: "5", flash_card_type: "Từ vựng Tiếng Anh giao tiếp cơ bản"),
    FlashCard(id: "6", flash_card_type:    "TOEFL Word List")
  ];
  final dio = Dio();

  Future<List<FlashCard>> fetchFlashCards() async{
    /*final response = await dio.get("path");

    if(response.statusCode == 200){
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json)=> SearchHistory.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load search history');
    }*/
    return List<FlashCard>.from(_flashCard);
  }
}