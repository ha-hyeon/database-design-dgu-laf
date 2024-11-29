import 'package:dgu_laf/screen/item/add_comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart';
import 'package:dgu_laf/service/item_service.dart';
import 'package:dgu_laf/service/comment_service.dart'; // 댓글 서비스
import 'package:dgu_laf/widget/comment_widget.dart'; // 댓글 위젯

class ItemDetailScreen extends StatefulWidget {
  final int itemId;

  const ItemDetailScreen({super.key, required this.itemId});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Future<Item> _itemFuture;
  late Future<List<Map<String, dynamic>>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _itemFuture = fetchItemDetails(widget.itemId);
    _commentsFuture = CommentService.fetchComments(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('분실물 정보'),
      ),
      body: FutureBuilder<Item>(
        future: _itemFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Item not found.'));
          }

          final item = snapshot.data!;
          final String labelText = item.itemType == "Lost" ? "찾아주세요" : "주인찾아요";
          final Color labelColor = item.itemType == "Lost"
              ? Theme.of(context).primaryColor
              : Colors.green;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/no_image.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '글쓴이: User ${item.userId}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      item.createdAt,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: labelColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        labelText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.class_, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '강의실: ${item.classroomId}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      '위치: ${item.detailLocation}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 36),
                const Divider(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _commentsFuture,
                      builder: (context, commentSnapshot) {
                        if (commentSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (commentSnapshot.hasError) {
                          return Center(
                            child: Text('Error: ${commentSnapshot.error}'),
                          );
                        } else if (!commentSnapshot.hasData ||
                            commentSnapshot.data!.isEmpty) {
                          return const Center(child: Text('No comments yet.'));
                        }

                        final comments = commentSnapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return CommentWidget(
                              commentId: comment['comment_id'],
                              commentUserId: comment['user_id'],
                              username: 'User ${comment['user_id']}',
                              content: comment['content'],
                              createdAt: comment['created_at'],
                              onDeleted: () {
                                setState(() {
                                  _commentsFuture =
                                      CommentService.fetchComments(
                                          widget.itemId);
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddCommentScreen(itemId: widget.itemId),
                            ),
                          );

                          if (result == true) {
                            // 댓글 등록 성공 시, 댓글 목록 다시 로드
                            setState(() {
                              _commentsFuture =
                                  CommentService.fetchComments(widget.itemId);
                            });
                          }
                        },
                        icon: const Icon(Icons.comment),
                        label: const Text('Add Comment'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
