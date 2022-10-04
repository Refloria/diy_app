// main.dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // 支持的地区（语言）
      supportedLocales: [
        const Locale('zh', 'CN'), // 简体中文
        const Locale('en', 'US'),
      ],

      // 本地化代理
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      theme: setupTheme(), // 主题
      home: SplashPage(), // 主页
      builder: EasyLoading.init(),

      navigatorKey: navigatorKey,
    );
  }

  /// 主题
  ThemeData setupTheme() {
    // EasyLoading样式设置
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.dark
      ..radius = 15.0
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..userInteractions = true
      ..dismissOnTap = true;

    // EasyRefresh样式设置
    EasyRefresh.defaultHeader =
        MaterialHeader(completeDuration: Duration(milliseconds: 500));
    EasyRefresh.defaultFooter = MaterialFooter();

    Color _primaryColor = Colors.blue[400];
    Color _accentColor = Colors.lightBlue[200];
    Color _backgroundColor = Colors.grey[50];
    return ThemeData(
      // 亮度主题，有白色/黑色两种可选
      brightness: Brightness.light,
      // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
      primaryColor: _primaryColor,
      // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
      primaryColorBrightness: Brightness.dark,
      // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
      accentColor: _accentColor,
      // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
      scaffoldBackgroundColor: _backgroundColor,
      textSelectionTheme: TextSelectionThemeData(
        // 文本框中光标的颜色，如TextField
        cursorColor: _primaryColor,
        // 用于调整当前选定的文本部分的句柄的颜色。
        selectionHandleColor: _primaryColor,
        // 文本框中文本选择的颜色，如TextField
        selectionColor: _accentColor,
      ),
      // 用于提示文本或占位符文本的颜色，例如在TextField中。
      hintColor: Colors.grey[400],
      // 用于自定义Appbar的主题，颜色、亮度、iconTheme、textTheme等。
      appBarTheme: AppBarTheme(
        elevation: 0, // 隐藏阴影
        brightness: Brightness.dark, // 状态栏文字为白色
      ),
      // ios风格控件主题
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: _backgroundColor,
        barBackgroundColor: _backgroundColor,
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/splash.jpg'),
      ),
    );
  }

  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString('token') ?? '';
    if (userToken == '') {
      MyNavigator.toLoginPage(context);
    } else {
      MyNavigator.toRootPage(context);
    }
  }
}
