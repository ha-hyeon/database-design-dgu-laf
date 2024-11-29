import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dgu_laf/service/comment_service.dart';

class CommentWidget extends StatefulWidget {
  final int commentId; // 댓글 ID
  final int commentUserId; // 댓글 작성자 ID
  final String username; // 댓글 작성자 이름
  final String content; // 댓글 내용
  final String createdAt; // 댓글 작성 시간
  final VoidCallback onDeleted; // 삭제 후 호출되는 콜백 함수

  const CommentWidget({
    super.key,
    required this.commentId,
    required this.commentUserId,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.onDeleted,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _isAuthor = false; // 현재 로그인 사용자가 작성자인지 여부

  @override
  void initState() {
    super.initState();
    _checkAuthorStatus();
  }

  Future<void> _checkAuthorStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id'); // 현재 로그인 사용자 ID 가져오기

    if (userId != null && userId == widget.commentUserId.toString()) {
      setState(() {
        _isAuthor = true; // 작성자와 동일하면 true
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.createdAt,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.content),
            const SizedBox(height: 8),
            if (_isAuthor) // 작성자인 경우에만 삭제 버튼 표시
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    final success = await CommentService.deleteComment(
                      widget.commentId,
                      widget.commentUserId,
                    );
                    if (success) {
                      widget.onDeleted(); // 댓글 삭제 후 갱신
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('댓글을 삭제할 수 없습니다.')),
                      );
                    }
                  },
                  child: const Text(
                    '삭제',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
