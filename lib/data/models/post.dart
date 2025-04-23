class Post {
  final String id;
  final String username;
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;
  final String avatarUrl;

  Post({
    required this.id,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    required this.avatarUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    print("Parsing Post JSON: $json"); // Thêm log để debug
    return Post(
      id: json['id']?.toString() ?? '', // Đảm bảo id không null
      username: json['username'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      content: json['content'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
}