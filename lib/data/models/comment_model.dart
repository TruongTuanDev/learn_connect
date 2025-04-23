class CommentModel {
  final String username;
  final String content;
  final DateTime time;

  CommentModel({required this.username, required this.content, required this.time});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      username: json['username'],
      content: json['content'],
      time: DateTime.parse(json['time']),
    );
  }
}
