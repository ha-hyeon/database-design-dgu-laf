import 'package:dgu_laf/widget/my_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/service/item_service.dart'; // 아이템 서비스를 import
import 'package:dgu_laf/model/item.dart'; // 아이템 모델 import

class MyItemScreen extends StatelessWidget {
  final String userId; // 사용자 ID (로그인된 사용자의 ID를 받아서 처리)

  const MyItemScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Items'),
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchMyItems(userId), // 사용자가 작성한 아이템 목록을 가져오는 함수
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return MyItemWidget(
                item: items[index],
                userId: userId,
              ); // 아이템 표시용 위젯
            },
          );
        },
      ),
    );
  }
}
