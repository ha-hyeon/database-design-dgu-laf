import 'package:dgu_laf/model/item.dart';
import 'package:dgu_laf/screen/item/create_item_screen.dart';
import 'package:dgu_laf/screen/item/my_item_screen.dart';
import 'package:dgu_laf/screen/main/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/service/item_service.dart';
import 'package:dgu_laf/widget/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  'Search items...',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyItemScreen()),
              );
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

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: fetchRecentItems(),
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
    );
  }
}
