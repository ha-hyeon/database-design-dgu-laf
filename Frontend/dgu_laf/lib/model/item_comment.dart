class ItemComment {
  final int commentId;
  final int userId;
  final int itemId;
  final bool isLost;
  final String content;
  final String createdAt;

  ItemComment({
    required this.commentId,
    required this.userId,
    required this.itemId,
    required this.isLost,
    required this.content,
    required this.createdAt,
  });

  factory ItemComment.fromJson(Map<String, dynamic> json) {
    return ItemComment(
      commentId: json['comment_id'],
      userId: json['user_id'],
      itemId: json['item_id'],
      isLost: json['is_lost'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'user_id': userId,
      'item_id': itemId,
      'is_lost': isLost,
      'content': content,
      'created_at': createdAt,
    };
  }
}
