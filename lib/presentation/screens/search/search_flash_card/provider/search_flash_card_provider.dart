import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/search_flash_card_model.dart';

// Provider cho FlashCardModel
final flashCardModelProvider = Provider((ref) => FlashCardModel());

// FutureProvider để fetch danh sách flashcards
final flashCardsProvider = FutureProvider<List<FlashCard>>((ref) async {
  final flashCardModel = ref.read(flashCardModelProvider);
  return await flashCardModel.fetchFlashCards();
});