import 'package:dgu_laf/screen/item/item_detail_screen.dart';
import 'package:dgu_laf/service/item_service.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart';

class MyItemWidget extends StatelessWidget {
  final Item item;
  final String userId; // 작성자 ID

  const MyItemWidget({super.key, required this.item, required this.userId});

  @override
  Widget build(BuildContext context) {
    final String labelText = item.itemType == "Lost" ? "찾아주세요" : "주인찾아요";
    final Color labelColor =
        item.itemType == "Lost" ? Theme.of(context).primaryColor : Colors.green;

    // Text editing controllers for updating the item
    final TextEditingController titleController =
        TextEditingController(text: item.title);
    final TextEditingController descriptionController =
        TextEditingController(text: item.description);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailScreen(itemId: item.itemId),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/no_image.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
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
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${item.createdAt}\n강의실: ${item.classroomId}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (item.userId.toString() == userId) // 작성자일 경우만 보여줌
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // 수정 로직
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    '글 수정',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 221, 147, 27),
                                    ),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // 내용을 다이얼로그 크기에 맞게 조정
                                      children: [
                                        // 제목 수정 TextField
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            hintText: '제목을 입력하세요',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueAccent),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 12),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 16), // 제목과 설명 사이에 간격
                                        // 설명 수정 TextField
                                        TextField(
                                          controller: descriptionController,
                                          decoration: InputDecoration(
                                            hintText: '설명을 입력하세요',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueAccent),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 12),
                                          ),
                                          maxLines: 4, // 여러 줄로 설명 입력 가능
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // 다이얼로그 모서리 둥글게
                                  ),
                                  actionsPadding: const EdgeInsets.all(12),
                                  actions: [
                                    // 수정 버튼
                                    TextButton(
                                      onPressed: () async {
                                        final response = await updateItem(
                                          userId: userId,
                                          itemId: item.itemId,
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                        );

                                        if (response['status'] == 'success') {
                                          Navigator.pop(
                                              context); // 수정 성공 후 다이얼로그 닫기
                                          // 화면 갱신 로직 추가 (필요시)
                                        } else {
                                          // 오류 처리
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('수정 실패, 다시 시도해주세요')),
                                          );
                                        }
                                      },
                                      child: Text(
                                        '수정',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              // 삭제 로직
                              final response =
                                  await deleteItem(itemId: item.itemId);

                              if (response['status'] == 'success') {
                                Navigator.pop(
                                    context); // MyItemScreen을 pop하여 화면 종료
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('아이템이 삭제되었습니다.')),
                                );
                              } else {
                                // 오류 처리
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('삭제 실패, 다시 시도해주세요')),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
