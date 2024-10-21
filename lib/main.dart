
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qualia/apis/database.dart';
import 'apps/my_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 设置状态栏为透明
    systemNavigationBarColor: Colors.transparent, // 设置系统导航栏为透明
    systemNavigationBarDividerColor:
        Colors.transparent, // 设置系统导航栏分隔线为透明 (仅 Android)
  ),);  // 设置UI模式
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge, // 应用内容延伸到边缘，覆盖状态栏和导航栏区域
  );
  await Database.instance.configureDio();

  runApp(const MyApp());
}



