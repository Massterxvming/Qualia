// ignore: file_names
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "搜索",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.only(
                left: 10, bottom: 10, top: 10), // 调整内部文字的位置
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // 这里添加过滤按钮的动作代码
            },
          ),
        ],
      ),
      body: CardList(), //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 添加你的动作代码
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final List<String> items = List<String>.generate(90, (i) => "Item $i");

  CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                // 处理点击事件
              },
              borderRadius: BorderRadius.circular(10), // 保持圆角一致性
              child: Ink(
                decoration: BoxDecoration(
                  // 通常情况下不可见，只有在点击时显示水波纹
                  borderRadius: BorderRadius.circular(10), // 保持圆角一致性
                ),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(6)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        Expanded(
                          // 使用Expanded来确保Text有限制的宽度
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              "我来测试省略号功能 ，用一段很长很长的文本😀",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      elevation: 0.5,
                      child: Ink(
                        width: double.infinity,
                        height: 240,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/cardImage.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 12,
                          backgroundImage:
                              AssetImage("assets/images/avatar.jpg"),
                        ),
                        const SizedBox(width: 8),
                        const Text("张玖雍"),
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up, size: 20),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark, size: 20),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, size: 20),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            const Column(
              children: [
                Divider(
                  thickness: 0.2,
                  height: 0,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
