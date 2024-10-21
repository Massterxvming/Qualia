import 'package:dio/dio.dart';

import '../common/common.dart';

class Database{

  Database._();

  static final _instance = Database._();

  static Database get instance =>_instance;

  late Dio _dio;

  late BaseOptions _options;

  late CancelToken _cancelToken;

  Dio get dio =>_dio;



  Future<void> configureDio() async{
    //create `Dio` with a `BaseOptions` instance.
    _options = BaseOptions(
      baseUrl: Config.dioBaseUrl,
      connectTimeout: Config.connecTimeout,
      receiveTimeout: Config.receiveTimeout,
      headers: {
        "vertion":'1.0.0'
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
    _dio = Dio(_options);

  }

  ///post请求
  post(url, {data, options, cancelToken}) async {
    Response response = Response(requestOptions: options);
    try {
      response = await _dio.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
      debugPrint('post success---------${response.data}');
    } on DioException catch (e) {
      debugPrint('post error---------$e');
      formatError(e);
    }
    return response.data;
  }

  ///get请求
  get(url, {data, options, cancelToken}) async {
    Response response = Response(requestOptions: options);
    try {
      response = await _dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      debugPrint('post success---------${response.data}');
    } on DioException catch (e) {
      debugPrint('post error---------$e');
      formatError(e);
    }
    return response.data;
  }
  
  ///put请求
  put(url, {data, options, cancelToken}) async {
    Response response = Response(requestOptions: options);
    try {
      response = await _dio.put(url, queryParameters: data, options: options, cancelToken: cancelToken);
      debugPrint('post success---------${response.data}');
    } on DioException catch (e) {
      debugPrint('post error---------$e');
      formatError(e);
    }
    return response.data;
  }

  ///delete请求
  delete(url, {data, options, cancelToken}) async {
    Response response = Response(requestOptions: options);
    try {
      response = await _dio.delete(url, queryParameters: data, options: options, cancelToken: cancelToken);
      debugPrint('post success---------${response.data}');
    } on DioException catch (e) {
      debugPrint('post error---------$e');
      formatError(e);
    }
    return response.data;
  }

  ///下载文件
  downloadFile(urlPath, savePath) async {
    var response;
    try {
      response = await _dio.download(urlPath, savePath,onReceiveProgress: (int count, int total){
        //进度
        debugPrint("$count $total");
      });
      debugPrint('downloadFile success---------${response.data}');
    } on DioException catch (e) {
      debugPrint('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  ///请求取消指令
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  ///证书校验
  // ...

  ///错误监听
  void formatError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      debugPrint("连接超时");
    } else if (e.type == DioExceptionType.sendTimeout) {
      debugPrint("请求超时");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      debugPrint("响应超时");
    } else if (e.type == DioExceptionType.badResponse) {
      debugPrint("出现异常");
    } else if (e.type == DioExceptionType.cancel) {
      debugPrint("请求取消");
    } else {
      debugPrint("未知错误");
    }
  }

}