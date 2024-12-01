import 'dart:io';

import 'package:dgu_laf/service/classroom_service.dart';
import 'package:dgu_laf/service/image_service.dart';
import 'package:dgu_laf/service/item_service.dart';
import 'package:dgu_laf/service/tag_service.dart';
import 'package:dgu_laf/service/upload_to_imgur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _classroomId = 1;
  int _tagId = 1; // 기본값: 모든 강의실
  String? userId; // userId를 저장할 변수

  final List<int> _classroomIds = List.generate(33, (index) => index + 1);
  final List<int> _tagIds = List.generate(9, (index) => index + 1);
  bool _isLoading = false;
  var _image; // 이미지 파일 변수

  @override
  void initState() {
    super.initState();
    _loadUserId(); // 화면이 시작될 때 userId를 로드
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id'); // user_id를 String 형식으로 가져옴
    });
  }

  void _submitForm() async {
    if (_titleController.text.isEmpty ||
        _itemDateController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        userId == null ||
        userId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await createItem(
        userId: userId!,
        itemType: _itemType,
        title: _titleController.text.trim(),
        itemDate: _itemDateController.text.trim(),
        description: _descriptionController.text.trim(),
        classroomId: _classroomId,
        tagId: _tagId,
        detailLocation: _detailLocationController.text.trim(),
      );

      if (response['status'] == 'success') {
        final itemId = response['item_id'];

        // Imgur 업로드된 URL을 서버로 전달
        if (_image != null) {
          final uploadResponse = await uploadImage(
            itemId: itemId,
            imageUrl: _image, // Imgur URL 전달
          );

          if (uploadResponse['status'] == 'success') {
            print('Image associated with item successfully');
          } else {
            print('Failed to associate image with item');
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item created successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create item')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// 이미지 업로드 함수
  Future<String?> _uploadImage(int itemId) async {
    try {
      // 이미지를 업로드하고 그 URL을 반환
      final imageUrl = await uploadToImgur(File(_image.path)); // File로 변환

      if (imageUrl != null) {
        return imageUrl; // 업로드된 이미지 URL 반환
      } else {
        print('Failed to upload image');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // 이미지 선택 함수 (예시)
  Future<void> pickImageAndUpload() async {
    final picker = ImagePicker();

    // 갤러리에서 이미지 선택
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Imgur에 이미지 업로드
      final imageUrl = await uploadToImgur(imageFile);

      if (imageUrl != null) {
        setState(() {
          _image = imageUrl; // 업로드된 이미지 URL 저장
        });
        print('Image uploaded: $imageUrl');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        backgroundColor: const Color.fromARGB(255, 255, 237, 215),
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
              DropdownButtonFormField<int>(
                value: _tagId,
                items: _tagIds.map((id) {
                  return DropdownMenuItem<int>(
                    value: id,
                    child: FutureBuilder<String?>(
                      future: TagService().getTagName(id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
              // 이미지 선택
              GestureDetector(
                onTap: () async {
                  await pickImageAndUpload();
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image == null
                      ? const Center(child: Text('이미지를 선택하세요'))
                      : Image.network(_image), // 업로드된 이미지 URL을 표시
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
                        horizontal: 24, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 255, 203, 144),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
