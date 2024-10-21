import 'package:dio/dio.dart';
import 'package:qualia/common/common.dart';
import 'package:qualia/controller/base.dart';

class AppController extends ControllerBase{
  //单例
  AppController._();
  static AppController _instance = AppController._();
  static get instance => _instance;


}