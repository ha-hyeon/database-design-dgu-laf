import 'package:dgu_laf/service/item_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({super.key});

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _itemDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailLocationController =
      TextEditingController();

  String _itemType = 'Lost'; // 기본값: Lost
  int _classroomId = 1; // 기본값: 모든 강의실

  final List<int> _classroomIds = List.generate(33, (index) => index + 1);

  bool _isLoading = false;

  void _submitForm() async {
    if (_titleController.text.isEmpty ||
        _itemDateController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _detailLocationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await createItem(
      itemType: _itemType,
      title: _titleController.text.trim(),
      itemDate: _itemDateController.text.trim(),
      description: _descriptionController.text.trim(),
      classroomId: _classroomId,
      detailLocation: _detailLocationController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item created successfully')),
      );
      Navigator.pop(context); // 이전 화면으로 돌아가기
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        backgroundColor: const Color.fromARGB(255, 255, 203, 144),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
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
                decoration: InputDecoration(
                  labelText: '타입',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.filter_alt_outlined),
                ),
              ),
              const SizedBox(height: 16),
              // 제목 입력
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '제목 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),
              // 날짜 입력
              TextField(
                controller: _itemDateController,
                decoration: InputDecoration(
                  labelText: '시간 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.date_range),
                ),
              ),
              const SizedBox(height: 16),
              // 설명 입력
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: '본문 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              // 강의실 선택
              DropdownButtonFormField<int>(
                value: _classroomId,
                items: [
                  const DropdownMenuItem(value: 1, child: Text('전체')), // 기본 옵션
                  ..._classroomIds.where((id) => id != 1).map((id) {
                    return DropdownMenuItem(
                      value: id,
                      child: Text('Classroom $id'),
                    );
                  }),
                ],
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
              const SizedBox(height: 16),
              // 세부 위치 입력
              TextField(
                controller: _detailLocationController,
                decoration: InputDecoration(
                  labelText: '세부 위치 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 24),
              // 등록 버튼
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save, size: 0),
                  label: _isLoading
                      ? const SizedBox.shrink()
                      : const Text(
                          '글 쓰기',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 122, vertical: 14),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
