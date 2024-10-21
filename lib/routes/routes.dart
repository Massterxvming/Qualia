import 'package:flutter/cupertino.dart';

import '../pages/page.dart';

class AppRoutes{

  AppRoutes._();

  // static String menu = '/';

  static String home= 'home';

  static String login = '/login';

  static String message = '/message';

  static String profit = '/profit';

}
Map<String,WidgetBuilder> Routes={
  // AppRoutes.menu :(e)=>HomeScreen(),

  AppRoutes.home: (e) => HomePage(),

  AppRoutes.login : (e)=> LoginPage(),

  AppRoutes.message : (e) =>MessagesPage(),

  AppRoutes.profit : (e)=> ProfilePage(),
};