import 'package:flutter/material.dart';

class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}
