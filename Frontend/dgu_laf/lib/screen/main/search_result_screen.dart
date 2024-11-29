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
        title: const Text('Search Results'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items match your search criteria.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemWidget(item: items[index]);
              },
            ),
    );
  }
}
