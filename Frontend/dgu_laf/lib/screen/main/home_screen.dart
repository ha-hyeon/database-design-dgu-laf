import 'package:dgu_laf/model/item.dart';
import 'package:dgu_laf/screen/item/create_item_screen.dart';
import 'package:dgu_laf/screen/main/myitem_screen.dart';
import 'package:dgu_laf/screen/main/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/service/item_service.dart';
import 'package:dgu_laf/widget/item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId; // userId를 저장할 변수

  @override
  void initState() {
    super.initState();
    _loadUserId(); // 사용자 ID 로드
  }

  // SharedPreferences에서 userId 로드
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // user_id를 String 형식으로 가져옴
      userId = prefs.getString('user_id'); // user_id를 String 형식으로 가져옴
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // 검색 필드를 클릭하면 검색 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.black38),
                SizedBox(width: 8),
                Text(
                  '분실물 검색하기...',
                  style: TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      body: const HomeScreenContent(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          switch (index) {
            case 1: // 검색 버튼
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
              break;
            case 2: // 내 물건 버튼
              if (userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyItemScreen(userId: userId!),
                  ),
                );
              } else {
                // userId가 null일 경우 처리 (예: 로그인 페이지로 이동)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please log in to view your items.')),
                );
              }
              break;
            case 3: // 글쓰기 버튼
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateItemScreen()),
              );
              break;
            default: // 홈 버튼
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'My Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create',
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  // 새로고침을 위한 Future
  late Future<List<Item>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = fetchRecentItems(); // 초기 데이터 로드
  }

  // 새로 고침할 때 호출되는 함수
  Future<void> _refreshItems() async {
    setState(() {
      _futureItems = fetchRecentItems(); // 새로 고침을 위해 다시 데이터를 로드
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshItems, // 새로 고침 시 호출될 함수
      child: FutureBuilder<List<Item>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recent items found'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemWidget(item: items[index]);
            },
          );
        },
      ),
    );
  }
}
