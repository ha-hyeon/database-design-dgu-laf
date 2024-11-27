import 'package:flutter/material.dart';
import 'package:dgu_laf/service/item_location_service.dart';
import 'package:dgu_laf/service/classroom_service.dart';

class ItemWidget extends StatelessWidget {
  final dynamic item;

  const ItemWidget({super.key, required this.item});

  Future<String> _getClassroomName(int locationId) async {
    final location = await ItemLocationService.getLocationById(locationId);
    final classroom =
        await ClassroomService.getClassroomById(location.classroomId);
    return '${classroom.buildingName} ${classroom.roomNumber}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getClassroomName(item.locationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(item.title),
            subtitle: const Text('Error fetching classroom info'),
          );
        }

        final classroomName = snapshot.data!;
        return Card(
          child: ListTile(
            leading: Image.asset(
              "images/no_image.jpg",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item.title),
            subtitle:
                Text('Posted: ${item.createdAt}\nClassroom: $classroomName'),
          ),
        );
      },
    );
  }
}
