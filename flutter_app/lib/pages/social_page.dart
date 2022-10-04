// social_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/article_list.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialPage extends StatefulWidget {
  SocialPage({Key key}) : super(key: key);

  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  // with AutomaticKeepAliveClientMixin {
  int _userId;
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    getUserId();
    // eventBus.on<FollowEvent>().listen((event) {
    //   print(event);
    //   if (mounted) _controller.callRefresh();
    // });
  }

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    setState(() {
      _userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    if (_userId == null) {
      return Text('loading');
    }
    return Scaffold(
      appBar: myAppBar(title: Text('我的社交')),
      body: ArticleList(
        isFollowList: true,
        userId: _userId,
        controller: _controller,
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
