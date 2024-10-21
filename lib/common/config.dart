

import 'common.dart';

class Config{
  Config._();

  static Size mobilSize = const Size(1334,750);

  ///Dio相关配置
  static String dioBaseUrl = '';

  static Duration connecTimeout = const Duration(seconds: 5);

  static Duration receiveTimeout = const Duration(seconds: 3);



}