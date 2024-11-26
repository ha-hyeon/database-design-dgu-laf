class ItemImage {
  final int imageId;
  final int itemId;
  final bool isLost;
  final String imageUrl;

  ItemImage({
    required this.imageId,
    required this.itemId,
    required this.isLost,
    required this.imageUrl,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      imageId: json['image_id'],
      itemId: json['item_id'],
      isLost: json['is_lost'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'item_id': itemId,
      'is_lost': isLost,
      'image_url': imageUrl,
    };
  }
}
