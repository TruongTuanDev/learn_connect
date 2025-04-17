class Post {
  final String username;
  final String timeAgo;
  final String content;
  final String avatarUrl;
  final int likes;
  final int comments;

  Post({
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.avatarUrl,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    username: json['username'],
    timeAgo: json['timeAgo'],
    content: json['content'],
    avatarUrl: json['avatarUrl'],
    likes: json['likes'],
    comments: json['comments'],
  );
}
