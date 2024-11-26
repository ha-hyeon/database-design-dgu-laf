class ItemLocation {
  final int locationId;
  final int classroomId;
  final String? detail;

  ItemLocation({
    required this.locationId,
    required this.classroomId,
    this.detail,
  });

  factory ItemLocation.fromJson(Map<String, dynamic> json) {
    return ItemLocation(
      locationId: json['location_id'],
      classroomId: json['classroom_id'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'classroom_id': classroomId,
      'detail': detail,
    };
  }
}
