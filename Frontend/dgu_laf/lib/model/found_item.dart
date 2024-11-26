class FoundItem {
  final int foundItemId;
  final int userId;
  final String title;
  final String description;
  final String foundDate;
  final int locationId;
  final String createdAt;

  FoundItem({
    required this.foundItemId,
    required this.userId,
    required this.title,
    required this.description,
    required this.foundDate,
    required this.locationId,
    required this.createdAt,
  });

  factory FoundItem.fromJson(Map<String, dynamic> json) {
    return FoundItem(
      foundItemId: json['found_item_id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      foundDate: json['found_date'],
      locationId: json['location_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'found_item_id': foundItemId,
      'user_id': userId,
      'title': title,
      'description': description,
      'found_date': foundDate,
      'location_id': locationId,
      'created_at': createdAt,
    };
  }
}
