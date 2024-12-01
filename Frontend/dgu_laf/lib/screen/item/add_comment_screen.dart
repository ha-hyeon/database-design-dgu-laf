import 'package:flutter/material.dart';
import 'package:dgu_laf/service/comment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCommentScreen extends StatefulWidget {
  final int itemId;

  const AddCommentScreen({super.key, required this.itemId});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final TextEditingController _contentController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitComment() async {
    setState(() {
      _isSubmitting = true;
    });

    // SharedPreferences에서 user_id 가져오기
    final prefs = await SharedPreferences.getInstance();
    final userIdStr = prefs.getString('user_id'); // String으로 가져오기

    if (userIdStr == null) {
      // 값이 없는 경우
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인이 필요합니다.')),
      );
      return;
    }

    final userId = int.tryParse(userIdStr); // String을 int로 변환

    if (userId == null) {
      // 변환 실패
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('저장된 사용자 정보가 잘못되었습니다.')),
      );
      return;
    }

    // 댓글 등록 요청
    final success = await CommentService.createComment(
      userId: userId,
      itemId: widget.itemId,
      content: _contentController.text.trim(),
    );

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('댓글이 등록되었습니다.')),
      );
      Navigator.pop(context, true); // 댓글 등록 성공 후 이전 화면으로
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('댓글 등록에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 215),
        title: const Text('댓글 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: '댓글 내용',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitComment,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('댓글 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
