// http_request.dart
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  /// default options
  static const int _connectTimeout = 600000;
  static const int _receiveTimeout = 600000;

  static const _serviceUrl = "http://192.168.2.143"; // 寝室
  // static const _serviceUrl = "http://10.206.175.156"; // 校园网
  // static const _serviceUrl = "http://192.168.1.5"; // 家里
  static const _port = "8081";
  static const baseUrl = _serviceUrl + ':' + _port;

  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: _connectTimeout,
    receiveTimeout: _receiveTimeout,
    responseType: ResponseType.json,
    validateStatus: (status) {
      // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      return true;
    },
    baseUrl: baseUrl,
    headers: {
      'Accept': 'application/json,*/*',
      'Content-Type': 'application/json',
      //'token':''
    },
  );

  static final Dio _dio = Dio(_baseOptions);

  static Future<T> post<T>(String api,
      {Map<String, dynamic> data, Interceptor inter, FormData formData}) async {
    // 1.请求的单独配置
    // final options = Options(method: method);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 2.添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          EasyLoading.show(status: 'loading...');
          // 在发送请求之前做一些预处理
          // 从SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
          // dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
          _dio.lock();
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = prefs.getString('token');
          options.headers["Authorization"] = token;
          _dio.unlock();
        },
        onResponse: (Response response) {
          // 在返回响应数据之前做一些预处理
          _dio.lock();
          print(response.realUri.toString() +
              ": " +
              response.data['code'].toString() +
              ': ' +
              response.data['message'].toString());
          switch (response.data['code']) {
            case 401:
              NavigatorState navigatorState = MyApp?.navigatorKey?.currentState;
              if (navigatorState != null) {
                navigatorState.pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              }
              break;
            case 403:
              EasyLoading.showError('没有权限');
              break;
            default:
              break;
          }
          if (response.headers['refresh-token'] != null) {
            prefs.setString('token', response.headers['refresh-token'][0]);
          }
          _dio.unlock();
          EasyLoading.dismiss();
          return response; // continue
        },
        onError: (DioError error) {
          // 当请求失败时做一些预处理
          print('error: ' + error.toString());
          EasyLoading.dismiss();
          return error; //continue
        },
      ),
    );

    // 3.发送网络请求
    try {
      Response response = await _dio.post<T>(api, data: data ?? formData);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
