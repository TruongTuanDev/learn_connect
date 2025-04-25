import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/search_flash_card_model.dart';

// Provider cho FlashCardModel
final flashCardModelProvider = Provider((ref) => FlashCardModel());

// FutureProvider để fetch danh sách flashcards
final flashCardsProvider = FutureProvider<List<FlashCard>>((ref) async {
  final flashCardModel = ref.read(flashCardModelProvider);
  return await flashCardModel.fetchFlashCards();
});

// StateProvider cho từ khóa tìm kiếm
final searchKeywordProvider = StateProvider<String>((ref) => "");

// Provider để lọc danh sách flashcards theo từ khóa tìm kiếm
final filteredFlashCardsProvider = Provider<List<FlashCard>>((ref) {
  final searchKeyword = ref.watch(searchKeywordProvider.state).state; // <-- Sửa lại
  final flashCardsAsync = ref.watch(flashCardsProvider);

  return flashCardsAsync.when(
    data: (flashCards) {
      return flashCards.where((flashcard) {
        return flashcard.title.toLowerCase().contains(searchKeyword.toLowerCase());
      }).toList();
    },
    loading: () => [],
    error: (error, stackTrace) => [],
  );
});
