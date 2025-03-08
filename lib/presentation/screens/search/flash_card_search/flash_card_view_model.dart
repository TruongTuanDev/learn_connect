import 'package:flutter/cupertino.dart';
import 'package:learn_connect/presentation/screens/search/flash_card_search/flash_card_model.dart';
import 'package:learn_connect/presentation/screens/search/search/search_history_model.dart';

class FlashCardViewModel extends ChangeNotifier{
  FlashCardModel flashCardModel = FlashCardModel();
  List<FlashCard> flash_cards = [];
  String? errorMessage;
  Future<void> init() async {
    try {
      flash_cards = (await flashCardModel.fetchFlashCards());
    } catch (e) {
      errorMessage = 'Could not fetch flashcards';
    }
    notifyListeners();
  }
}