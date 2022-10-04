//person_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonPage extends StatefulWidget {
  PersonPage({Key key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  int _userId;

  /// 用户昵称
  String _nickname;

  /// 用户头像
  String _userPic;

  /// 用户名
  String _username;

  /// 教程数量
  int _articles;

  /// 关注人数
  int _follows;

  /// 粉丝人数
  int _fans;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  void _loadDetail() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user_id');

    final Map<String, dynamic> result = await HttpRequest.post(
      '/getPersonPageDetail',
      data: {'id': _userId},
    );
    if (result['code'] == 200) {
      final Map<String, dynamic> data = result['data'];
      setState(() {
        _nickname = data['nickname'];
        _userPic = data['picture'];
        _username = data['username'];
        _articles = data['articles'];
        _follows = data['follows'];
        _fans = data['fans'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(height: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
              decoration: BoxDecoration(color: Colors.blue[400]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5),
                      UserAvatar(radius: 35, borderWidth: 2, picUrl: _userPic),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _nickname ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '用户名：' + (_username ?? ''),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        onPressed: () => MyNavigator.toPersonSocialPage(context,
                            userId: _userId),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70.0,
                    child: Row(
                      children: [
                        PersonBarItem(
                          title: '缝绣作品',
                          number: _articles ?? 0,
                          onTap: () {
                            if (_userId != null) {
                              MyNavigator.toMyArticlePage(context,
                                  userId: _userId);
                            }
                          },
                        ),
                        VerticalDivider(
                            color: Colors.white, indent: 20, endIndent: 20),
                        PersonBarItem(
                          title: '关注',
                          number: _follows ?? 0,
                          onTap: () {
                            if (_userId != null) {
                              MyNavigator.toFansOrFollowPage(context,
                                  userId: _userId, isFollow: true);
                            }
                          },
                        ),
                        VerticalDivider(
                            color: Colors.white, indent: 20, endIndent: 20),
                        PersonBarItem(
                          title: '粉丝',
                          number: _fans ?? 0,
                          onTap: () {
                            if (_userId != null) {
                              MyNavigator.toFansOrFollowPage(context,
                                  userId: _userId, isFollow: false);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('发布作品'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                MyNavigator.toArticleEditPage(context);
              },
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('待审核作品'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                MyNavigator.toMyArticlePage(context,
                    userId: _userId, articleState: 0);
              },
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('已下架作品'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                MyNavigator.toMyArticlePage(context,
                    userId: _userId, articleState: 2);
              },
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('账号管理'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                MyNavigator.toPersonDetailSettingPage(context, userId: _userId);
              },
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('意见反馈'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            Divider(height: 1.0),
            TextButton(
              onPressed: _logoutDialog,
              child: Text(
                '退出登录',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logoutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('确认退出登录吗？'),
            actions: <Widget>[
              TextButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('确认'),
                onPressed: _logout,
              ),
            ],
          );
        });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    prefs.remove('token');
    prefs.remove('refresh_token');
    MyNavigator.toLoginPage(context);
  }
}

class PersonBarItem extends StatelessWidget {
  final String title;
  final number;
  final GestureTapCallback onTap;

  PersonBarItem({Key key, this.title, this.number, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(number.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 3.0),
            Text(title.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12))
          ],
        ),
      ),
    );
  }
}
