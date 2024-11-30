class Item {
  final int itemId;
  final int userId;
  final String title;
  final String description;
  final String itemDate;
  final int classroomId;
  final int tagId;
  final String detailLocation;
  final String createdAt;
  final String itemType; // Lost or Found

  Item({
    required this.itemId,
    required this.userId,
    required this.title,
    required this.description,
    required this.itemDate,
    required this.classroomId,
    required this.tagId,
    required this.detailLocation,
    required this.createdAt,
    required this.itemType,
  });

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메소드
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: int.tryParse(json['item_id'].toString()) ?? 0, // 문자열을 int로 변환
      userId: int.tryParse(json['user_id'].toString()) ?? 0, // 문자열을 int로 변환
      title: json['title'],
      description: json['description'],
      itemDate: json['item_date'],
      classroomId: int.tryParse(json['classroom_id'].toString()) ?? 1,
      tagId: int.tryParse(json['tagId'].toString()) ?? 1, // 문자열을 int로 변환
      detailLocation: json['detail_location'] ?? '',
      createdAt: json['created_at'],
      itemType: json['item_type'],
    );
  }
}
