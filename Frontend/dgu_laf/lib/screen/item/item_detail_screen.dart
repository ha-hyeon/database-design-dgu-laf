import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart';
import 'package:dgu_laf/service/item_service.dart';

class ItemDetailScreen extends StatefulWidget {
  final int itemId; // 아이템 ID를 전달받음

  const ItemDetailScreen({super.key, required this.itemId});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Future<Item> _itemFuture;

  @override
  void initState() {
    super.initState();
    _itemFuture = fetchItemDetails(widget.itemId); // 아이템 상세 정보 로드
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
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Item not found.'));
          }

          final item = snapshot.data!;

          // 아이템 유형 라벨
          final String labelText = item.itemType == "Lost" ? "찾아주세요" : "주인찾아요";
          final Color labelColor = item.itemType == "Lost"
              ? Theme.of(context).primaryColor // 파란색
              : Colors.green; // 초록색

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // 이미지
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/no_image.jpg', // 기본 이미지
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                // 글쓴이, 시간
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
                // 제목과 라벨
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 라벨
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
                    // 제목
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
                // 강의실 및 세부 위치
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
                // 설명
                const SizedBox(height: 20),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 36),
                const Divider(height: 24),
                // 댓글 섹션
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
                    // 더미 댓글 리스트 (실제 데이터 연결 필요)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, // 예시: 댓글 3개
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('User $index'),
                          subtitle: const Text('This is a comment.'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // 댓글 삭제 기능 추가
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // 댓글 달기 버튼
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // 댓글 작성 기능 추가
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
