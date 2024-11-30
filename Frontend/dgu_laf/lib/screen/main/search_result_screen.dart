import 'package:dgu_laf/widget/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:dgu_laf/model/item.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Item> items;

  const SearchResultScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 215),
        title: const Text('검색 결과'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('분실물이 없습니다.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemWidget(item: items[index]);
              },
            ),
    );
  }
}
