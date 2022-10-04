import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/article_list_item.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonSocialPage extends StatefulWidget {
  final int userId;

  PersonSocialPage({Key key, this.userId}) : super(key: key);

  @override
  _PersonSocialPageState createState() => _PersonSocialPageState();
}

class _PersonSocialPageState extends State<PersonSocialPage> {
  // 总数
  int _currentPage = 0;
  // 连接通知器
  LinkHeaderNotifier _headerNotifier;
  EasyRefreshController _controller;
  ScrollController _scrollController = ScrollController();

  String _userNickname = '', _userPicture;

  bool _isFollow = false;
  int _count = 0;

  List<dynamic> _articles = [];

  @override
  void initState() {
    super.initState();
    _headerNotifier = LinkHeaderNotifier();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _headerNotifier.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
            controller: _scrollController,
            radius: Radius.circular(8.0),
            child: EasyRefresh.custom(
              scrollController: _scrollController,
        controller: _controller,
        header: LinkHeader(
          _headerNotifier,
          extent: 70.0,
          triggerDistance: 70.0,
          completeDuration: Duration(milliseconds: 500),
        ),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.grey[100],
            elevation: 0,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    'https://c-ssl.duitang.com/uploads/item/201807/08/20180708174552_uEjQA.thumb.1000_0.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                FlexibleSpaceBar(
                  centerTitle: false,
                  title: Row(
                    children: [
                      UserAvatar(
                          picUrl: _userPicture, radius: 18, borderWidth: 1),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _userNickname,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  titlePadding: EdgeInsetsDirectional.only(
                      start: 50, bottom: 10, end: 20),
                ),
              ],
            ),
            actions: <Widget>[
              CircleHeader(_headerNotifier),
              Container(
                child: myFlatButton(
                    onPressed: _followButtonPress,
                    text: _isFollow ? '已关注' : '+ 关注'),
                margin: EdgeInsets.fromLTRB(0, 12, 10, 12),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 5),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= _articles.length) {
                    return myListEnd();
                  }
                  Map<String, dynamic> record = _articles[index];
                  return ArticleListItem(
                    articleId: record['id'],
                    coverPicUrl: record['coverPic'],
                    articleTitle: record['title'],
                    authorName: record['userNickname'],
                    authorPicUrl: record['userPicture'],
                    publishTime: record['publishTime'],
                  );
                },
                childCount: _count,
              ),
            ),
          ),
        ],
        onRefresh: _refresh,
        onLoad: _loadMore,
        firstRefresh: true,
        footer: MaterialFooter(),
      ),),
    );
  }

  Future<void> _refresh() async {
    _currentPage = 0;
    Map<String, dynamic> result = await HttpRequest.post(
      '/getUserDetailWithFollow',
      data: {'id': widget.userId},
    );
    if (result['code'] == 200) {
      setState(() {
        _userNickname = result['data']['nickname'];
        _userPicture = result['data']['picture'];
        _isFollow = result['data']['isFollow'];
      });
    } else {
      EasyLoading.showToast(result['message']);
    }
    setState(() {
      _articles.clear();
    });
    _loadMore();
  }

  Future<void> _loadMore() async {
    _currentPage++;
    Map<String, dynamic> result = await HttpRequest.post(
      '/getArticlePageList',
      data: {
        'page': {'size': 7, 'current': _currentPage},
        'userId': widget.userId,
      },
    );
    if (result['code'] == 200) {
      List<dynamic> records = result['data']['records'];
      setState(() {
        _articles.addAll(records);
        _controller.finishLoad(noMore: _currentPage >= result['data']['pages']);
        _count = _articles.length +
            (_currentPage >= result['data']['pages'] ? 1 : 0);
      });
    } else {
      EasyLoading.showToast(result['message']);
    }
  }

  /// 关注按钮点击
  void _followButtonPress() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? '';
    Map<String, dynamic> result;
    final Map<String, dynamic> data = {
      'followUserId': widget.userId,
      'userId': userId
    };

    if (_isFollow) {
      result = await HttpRequest.post('/cancelFollow', data: data);
    } else {
      result = await HttpRequest.post('/follow', data: data);
    }
    if (result['code'] == 200) {
      setState(() {
        _isFollow = !_isFollow;
      });
    } else {
      EasyLoading.showToast(result['message']);
    }
  }
}

// 圆形Header
class CircleHeader extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const CircleHeader(this.linkNotifier, {Key key}) : super(key: key);

  @override
  CircleHeaderState createState() {
    return CircleHeaderState();
  }
}

class CircleHeaderState extends State<CircleHeader> {
  // 指示器值
  double _indicatorValue = 0.0;

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  @override
  void initState() {
    super.initState();
    widget.linkNotifier.addListener(onLinkNotify);
  }

  void onLinkNotify() {
    setState(() {
      if (_refreshState == RefreshMode.armed ||
          _refreshState == RefreshMode.refresh) {
        _indicatorValue = null;
      } else if (_refreshState == RefreshMode.refreshed ||
          _refreshState == RefreshMode.done) {
        _indicatorValue = 1.0;
      } else {
        if (_refreshState == RefreshMode.inactive) {
          _indicatorValue = 0.0;
        } else {
          double indicatorValue = _pulledExtent / 70.0 * 0.8;
          _indicatorValue = indicatorValue < 0.8 ? indicatorValue : 0.8;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          right: 20.0,
        ),
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          value: _indicatorValue,
          valueColor: AlwaysStoppedAnimation(Colors.white70),
          strokeWidth: 2.4,
        ),
      ),
    );
  }
}
