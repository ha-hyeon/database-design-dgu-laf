import 'package:dgu_laf/screen/main/search_result_screen.dart';
import 'package:dgu_laf/service/classroom_service.dart';
import 'package:dgu_laf/service/tag_service.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart';
import 'package:dgu_laf/service/item_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _itemType = 'Lost'; // 기본값
  int _classroomId = 1; // 기본값: 모든 강의실
  int _tagId = 1;
  // 강의실 목록
  final List<int> _classroomIds = List.generate(33, (index) => index + 1);
  final List<int> _tagIds = List.generate(9, (index) => index + 1);

  void _performSearch() async {
    // 필터링된 아이템 목록 가져오기
    final items = await fetchFilteredItems(
      title: _titleController.text.trim(),
      classroomId: _classroomId,
      tagId: _tagId,
      itemType: _itemType,
    );

    // 검색 결과 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(items: items),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('분실물 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '검색어를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 아이템 타입 선택
            DropdownButtonFormField<String>(
              value: _itemType,
              items: const [
                DropdownMenuItem(value: 'Lost', child: Text('찾아주세요')),
                DropdownMenuItem(value: 'Found', child: Text('주인찾아요')),
              ],
              onChanged: (value) {
                setState(() {
                  _itemType = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Item Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _tagId,
              items: _tagIds.map((id) {
                return DropdownMenuItem<int>(
                  value: id,
                  child: FutureBuilder<String?>(
                    future: TagService().getTagName(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...'); // 로딩 상태
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Text('Tag $id'); // 에러나 데이터 없음
                      } else {
                        return Text(snapshot.data!); // tag_name 표시
                      }
                    },
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tagId = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: '태그 선택',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 강의실 선택
            DropdownButtonFormField<int>(
              value: _classroomId,
              items: _classroomIds.map((id) {
                return DropdownMenuItem<int>(
                  value: id,
                  child: FutureBuilder<String?>(
                    future: ClassroomService().getBuildingName(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...'); // 로딩 상태
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Text('Classroom $id'); // 에러나 데이터 없음
                      } else {
                        return Text(snapshot.data!); // building_name 표시
                      }
                    },
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _classroomId = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: '강의실 선택',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // 검색 버튼
            Center(
              child: ElevatedButton.icon(
                onPressed: _performSearch,
                icon: const Icon(Icons.search),
                label: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
