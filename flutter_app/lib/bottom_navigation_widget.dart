// bottom_navigation_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/article_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/person_page.dart';
import 'package:flutter_app/pages/social_page.dart';
import 'package:flutter_app/utils/iconfont.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> _pages = [HomePage(), ArticlePage(), SocialPage(), PersonPage()];
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动切换页面
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Iconfont.home_outline),
              activeIcon: Icon(Iconfont.home_filled),
              label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.sewing_outline),
              activeIcon: Icon(Iconfont.sewing_filled),
              label: '缝绣天地'),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.compass_outline),
              activeIcon: Icon(Iconfont.compass_filled),
              label: '我的社交'),
          BottomNavigationBarItem(
              icon: Icon(Iconfont.person_outline),
              activeIcon: Icon(Iconfont.person_filled),
              label: '个人中心')
        ],
        onTap: (int index) {
          if (_currentIndex != index) {
            setState(() {
              _controller.jumpToPage(index);
            });
          }
        },
      ),
    );
  }
}
