import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10, // 示例消息数量
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.message),
            title: Text('消息 ${index + 1}'),
            subtitle: const Text('这是消息详情'),
          );
        },
      ),
    );
  }
}
