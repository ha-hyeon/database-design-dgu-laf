class Classroom {
  final int classroomId;
  final String buildingName;
  final String roomNumber;

  Classroom({
    required this.classroomId,
    required this.buildingName,
    required this.roomNumber,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      classroomId: json['classroom_id'],
      buildingName: json['building_name'],
      roomNumber: json['room_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classroom_id': classroomId,
      'building_name': buildingName,
      'room_number': roomNumber,
    };
  }
}
