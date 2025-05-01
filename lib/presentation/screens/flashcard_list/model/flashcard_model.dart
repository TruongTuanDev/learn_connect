class FlashcardModel {
  final String front;
  final String back;
  final String pronunciation;

  const FlashcardModel({
    required this.front,
    required this.back,
    this.pronunciation = '',
  });
}
