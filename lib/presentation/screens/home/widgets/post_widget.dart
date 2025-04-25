import 'package:flutter/material.dart';
import 'package:learn_connect/services/api_service.dart';
import 'package:learn_connect/data/models/comment_model.dart';

class PostWidget extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;
  final String avatarUrl;
  final String postId;

  const PostWidget({
    Key? key,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    required this.avatarUrl,
    required this.postId,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _liked = false;
  int _likeCount = 0;
  bool _showComments = false;
  List<CommentModel> _comments = [];
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _likeCount = widget.likes;
    print("PostWidget initialized with postId: ${widget.postId}");
    _loadInitialData(); // Tải dữ liệu ban đầu
  }

  Future<void> _loadInitialData() async {
    String postId = widget.postId.isEmpty ? "1" : widget.postId;
    try {
      // Tải số lượt Like từ server
      final likeCount = await ApiService.fetchLikeStatus(postId);
      setState(() {
        _likeCount = likeCount;
        // Giả sử _liked ban đầu là false, cần logic thêm để xác định trạng thái từ server
      });

      // Tải comment ban đầu
      final comments = await ApiService.fetchComments(postId);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print("Load initial data error: $e");
    }
  }

  Future<void> _handleLike() async {
    String postId = widget.postId.isEmpty ? "1" : widget.postId;
    print("Post ID for liking: $postId, current liked state: $_liked");
    try {
      // Gửi hành động dựa trên trạng thái mới (sau khi toggle)
      final newLikedState = !_liked;
      int updatedCount = await ApiService.likePost(postId, _liked);
      setState(() {
        _liked = newLikedState;
        _likeCount = updatedCount;
        print("Like toggled: $_liked, count: $_likeCount");
      });
    } catch (e) {
      print("Like error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update like')),
      );
    }
  }

  Future<void> _toggleComments() async {
    setState(() {
      _showComments = !_showComments;
    });
    if (_showComments) {
      String postId = widget.postId.isEmpty ? "1" : widget.postId;
      print("Post ID for fetching comments: $postId");
      try {
        final comments = await ApiService.fetchComments(postId);
        setState(() {
          _comments = comments;
        });
      } catch (e) {
        print("Load comments error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load comments')),
        );
      }
    }
  }

  Future<void> _submitComment() async {
    String content = _commentController.text.trim();
    if (content.isEmpty) return;

    String postId = widget.postId.isEmpty ? "1" : widget.postId;
    print("Post ID for adding comment: $postId");
    try {
      await ApiService.addComment(postId, "You", content);
      _commentController.clear();
      final comments = await ApiService.fetchComments(postId);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print("Comment error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add comment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatarUrl),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.timeAgo, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.content, style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: _handleLike,
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up,
                          size: 18, color: _liked ? Colors.green : Colors.grey),
                      SizedBox(width: 5),
                      Text("$_likeCount"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: _toggleComments,
                  child: Row(
                    children: [
                      Icon(Icons.comment, size: 18, color: Colors.grey),
                      SizedBox(width: 5),
                      Text("${_comments.length}"),
                    ],
                  ),
                ),
              ],
            ),
            if (_showComments) ...[
              Divider(),
              Column(
                children: _comments.map((c) {
                  return ListTile(
                    dense: true,
                    leading: Icon(Icons.person, size: 20),
                    title: Text(c.username, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(c.content),
                  );
                }).toList(),
              ),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Viết bình luận...",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _submitComment,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}