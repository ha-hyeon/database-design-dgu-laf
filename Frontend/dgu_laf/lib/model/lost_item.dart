class LostItem {
  final int lostItemId;
  final int userId;
  final String title;
  final String description;
  final String lostDate;
  final int locationId;
  final String createdAt;

  LostItem({
    required this.lostItemId,
    required this.userId,
    required this.title,
    required this.description,
    required this.lostDate,
    required this.locationId,
    required this.createdAt,
  });

  factory LostItem.fromJson(Map<String, dynamic> json) {
    return LostItem(
      lostItemId: json['lost_item_id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      lostDate: json['lost_date'],
      locationId: json['location_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lost_item_id': lostItemId,
      'user_id': userId,
      'title': title,
      'description': description,
      'lost_date': lostDate,
      'location_id': locationId,
      'created_at': createdAt,
    };
  }
}
