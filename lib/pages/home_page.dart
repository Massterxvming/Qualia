import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qualia/common/common.dart';
import 'package:qualia/widgets/CardOptionsDialog.dart';

import '../models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;
  Future<List<CardItem>>? _futureCardItems;
  int crossAxisCount = 2; // 初始列数

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // _futureCardItems = fetchCardItems(); // 在initState中初始化，确保只调用一次
  }

  void _scrollListener() {
    final bool shouldShowFab = _scrollController.position.userScrollDirection ==
        ScrollDirection.forward;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 50), () {
      if (shouldShowFab != _showFab) {
        setState(() {
          _showFab = shouldShowFab;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    crossAxisCount = max(2, screenWidth ~/ 360); // 动态设置列数

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '与你分享',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ],
        ),
        //   body: FutureBuilder<List<CardItem>>(
        //     future: _futureCardItems,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasError) {
        //         return Text("Error: ${snapshot.error}");
        //       } else {
        //         return MasonryGridView.count(
        //           padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        //           controller: _scrollController,
        //           crossAxisCount: crossAxisCount,
        //           mainAxisSpacing: 4,
        //           crossAxisSpacing: 4,
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, index) {
        //             var item = snapshot.data![index];
        //             return buildCard(context, item);
        //           },
        //         );
        //       }
        //     },
        //   ),
        //   floatingActionButton: _showFab
        //       ? screenWidth < 600
        //           ? FloatingActionButton(
        //               onPressed: () {},
        //               child: const Icon(Icons.edit_note_sharp),
        //             )
        //           : FloatingActionButton.extended(
        //               onPressed: () {},
        //               icon: const Icon(Icons.edit_note_sharp),
        //               label: const Text('发布'),
        //             )
        //       : null,
        // );
        body: MasonryGridView.count(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: _scrollController,
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: 20,
          itemBuilder: (context, index) {
            CardItem item;
            if (index % 2 == 0) {
              item = CardItem(
                  uid: '1',
                  image: 'assets/images/1.png',
                  avatar: "avatar",
                  title: "title",
                  user: "user");
            } else {
              item = CardItem(
                  uid: '1',
                  image: 'assets/images/2.jpg',
                  avatar: "avatar",
                  title: "title",
                  user: "user");
            }
            return buildCard(context, item);
          },
        ));
  }

  Widget buildCard(BuildContext context, CardItem item) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const CardOptionsDialog(),
          );
        },
        onTap: () {},
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AdaptiveImage(
                key: ValueKey(item.image),
                imageUrl: item.image,
                onHeightDetermined: (double height) {},
                crossAxisCount: crossAxisCount, // 传递crossAxisCount
              ),
              Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w, right: 0.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.user,
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 20,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdaptiveImage extends StatefulWidget {
  final String imageUrl;
  final double maxHeight;
  final double minHeight;
  final int crossAxisCount;
  final Function(double)? onHeightDetermined; // 新增一个回调

  const AdaptiveImage({
    super.key,
    required this.imageUrl,
    this.maxHeight = 460.0,
    this.minHeight = 100.0,
    required this.crossAxisCount,
    this.onHeightDetermined, // 将回调作为可选参数
  });

  @override
  _AdaptiveImageState createState() => _AdaptiveImageState();
}

class _AdaptiveImageState extends State<AdaptiveImage> {
  double? _height;
  final Map<String, double> _heightCache = {}; // 缓存图片高度

  @override
  void initState() {
    super.initState();
    if (_heightCache.containsKey(widget.imageUrl)) {
      _height = _heightCache[widget.imageUrl];
    } else {
      _calculateImageDimension();
    }
  }

  void _calculateImageDimension() {
    final ImageStream imageStream =
        Image.asset(widget.imageUrl).image.resolve(const ImageConfiguration());
    imageStream.addListener(
      ImageStreamListener(
        (ImageInfo imageInfo, bool synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (mounted) {
                final screenWidth = MediaQuery.of(context).size.width /
                    widget.crossAxisCount; // 调整计算宽度
                final calculatedHeight = screenWidth / aspectRatio;
                final adjustedHeight =
                    calculatedHeight.clamp(widget.minHeight, widget.maxHeight);
                setState(() {
                  _height = adjustedHeight;
                  _heightCache[widget.imageUrl] = adjustedHeight; // 缓存高度
                });
                if (widget.onHeightDetermined != null) {
                  widget.onHeightDetermined!(adjustedHeight);
                }
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _height == null
        ? const SizedBox.shrink()
        : SizedBox(
            height: _height,
            width: double.infinity,
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          );
  }
}
