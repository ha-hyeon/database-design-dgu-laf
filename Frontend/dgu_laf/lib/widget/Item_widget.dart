import 'package:dgu_laf/screen/item/item_detail_screen.dart';
import 'package:dgu_laf/service/classroom_service.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart'; // ItemDetailScreen import

class ItemWidget extends StatefulWidget {
  final Item item;

  const ItemWidget({super.key, required this.item});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  // 태그 ID와 이미지 경로 매핑
  final Map<int, String> tagImageMap = {
    1: "assets/images/no_image.jpg",
    2: "assets/images/electronic.jpg",
    3: "assets/images/wallet.jpg",
    4: "assets/images/card.png",
    5: "assets/images/person.jpg",
    6: "assets/images/clothes.jpg",
    7: "assets/images/glasses.jpg",
    8: "assets/images/ring.jpg",
    9: "assets/images/no_image.jpg", // 태그 9는 no_image로 설정
  };

  @override
  Widget build(BuildContext context) {
    // 아이템 유형 라벨 설정
    final String labelText = widget.item.itemType == "Lost" ? "찾아주세요" : "주인찾아요";
    final Color labelColor = widget.item.itemType == "Lost"
        ? Theme.of(context).primaryColor // 파란색
        : Colors.green; // 초록색

    // 태그 ID에 따른 이미지 경로 가져오기 (기본 이미지 설정)
    String? imagePath = tagImageMap[widget.item.tagId];

    return GestureDetector(
      onTap: () {
        // 아이템 상세 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailScreen(itemId: widget.item.itemId),
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
              // 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imagePath!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/no_image.jpg", // 기본 이미지
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // 텍스트 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 라벨과 제목
                    Row(
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
                            widget.item.title,
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
                    // 설명 텍스트
                    Text(
                      widget.item.createdAt,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    FutureBuilder<String?>(
                      future: ClassroomService().getBuildingName(
                          widget.item.classroomId), // building_name 조회
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading...'); // 로딩 중
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Text(
                              'Classroom ${widget.item.classroomId}'); // 에러 시 기본값 표시
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text(
                              'Building name not found'); // building_name이 없으면 기본 텍스트 표시
                        } else {
                          return Text('강의실: ${snapshot.data!}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall); // building_name 표시
                        }
                      },
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
