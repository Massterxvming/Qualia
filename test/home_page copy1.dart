import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showFab) {
        setState(() {
          _showFab = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showFab) {
        setState(() {
          _showFab = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;

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
            contentPadding:
                const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: CardList(controller: _scrollController),
      floatingActionButton: _showFab
          ? screenWidth < 600
              ? FloatingActionButton(
                  onPressed: () {
                    // FAB动作
                  },
                  child: const Icon(Icons.edit_note_sharp),
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    // FAB动作
                  },
                  icon: const Icon(Icons.edit_note_sharp),
                  label: const Text('发布'),
                )
          : null,
    );
  }
}

class CardList extends StatelessWidget {
  final List<String> items = List<String>.generate(90, (i) => "Item $i");
  final ScrollController controller;

  CardList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度
    double screenWidth = MediaQuery.of(context).size.width;
    // 基于屏幕宽度动态计算列数，例如每列最小宽度为360
    int crossAxisCount = max(2, screenWidth ~/ 360); // 确保至少有一列

    return MasonryGridView.count(
      controller: controller, // 使用传入的ScrollController
      crossAxisCount: crossAxisCount, // 使用动态计算的列数
      mainAxisSpacing: 4, // 主轴间距
      crossAxisSpacing: 4, // 交叉轴间距
      itemCount: items.length,
      itemBuilder: (context, index) => buildCard(context, index),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias, // 确保Card的内容被裁剪到圆角形状
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // 圆角大小
      ),
      child: InkWell(
        onLongPress: () {},
        onTap: () {},
        child: Material(
          type: MaterialType.transparency, // 使用透明材质以避免任何视觉影响
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                //
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0), bottom: Radius.circular(10.0)),
                child: Image.asset(
                  'assets/images/1.png', // 这里是image的位置
                  width: double.infinity,
                  height: 150, // 可以调整图片的高度
                  fit: BoxFit.cover,
                ),

                /*Image.asset(
                  'assets/images/1.png', // 这里替换成你想要显示的图片URL
                  width: double.infinity,
                  height: 150, // 可以调整图片的高度
                  fit: BoxFit.cover,
                ),*/
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Qualia正确的打开方式', // 这里是title的位置
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold), // 加粗，稍大的字体
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Qualia官方团队', //这里是user的位置
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    // 用户ID文本
                    IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.thumb_up_alt_outlined), // 点赞按钮图标
                      onPressed: () {
                        // 点赞按钮的点击事件处理
                      },
                    ),
                  ],
                ),
              ),
              // 如果有其他组件需要添加，可以继续在这里添加
            ],
          ),
        ),
      ),
    );
  }
}
