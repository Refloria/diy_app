import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/person_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FansFollowPage extends StatefulWidget {
  /// 列表归属者的id
  final int userId;

  /// 是关注列表还是粉丝列表
  final bool isFollow;

  FansFollowPage({Key key, this.userId, this.isFollow = false})
      : super(key: key);

  @override
  _FansFollowPageState createState() => _FansFollowPageState();
}

class _FansFollowPageState extends State<FansFollowPage> {
  var currentPage = 0;
  var pageSize = 20;
  List<Widget> people = [];
  EasyRefreshController _controller;
  bool _isEmpty = true;
  bool _isMine = true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _judgeMine();
  }

  void _judgeMine() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != widget.userId) {
      setState(() {
        _isMine = false;
      });
    }
  }

  Future<void> _loadMore() async {
    currentPage++;
    Map<String, dynamic> result, data;
    data = {
      'page': {'current': currentPage, 'size': pageSize},
      'userId': widget.userId
    };
    if (widget.isFollow) {
      result = await HttpRequest.post('/getFollowPageList', data: data);
    } else {
      result = await HttpRequest.post('/getFansPageList', data: data);
    }
    if (result['code'] == 200) {
      List<Widget> morePeople = [];
      for (var item in result['data']['records']) {
        if (_isEmpty) {
          _isEmpty = false;
        } else {
          morePeople.add(Divider(height: 1, indent: 5, endIndent: 5));
        }
        morePeople.add(PersonListItem(
          userId: item['id'],
          userPic: item['picture'],
          nickName: item['nickname'],
          // isFollowItem: widget.isFollow,
          isFollow: item['isFollow'],
        ));
      }
      setState(() {
        people.addAll(morePeople);
        _controller.finishLoad(noMore: currentPage >= result['data']['pages']);
      });
      if (currentPage >= result['data']['pages']) {
        setState(() {
          people.add(myListEnd());
        });
      }
    } else {
      print('load people list error. msg:' + result['message'] ?? '');
      currentPage--;
    }
  }

  Future<void> _onRefresh() async {
    currentPage = 0;
    people.clear();
    _isEmpty = true;
    await _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: Text(_isMine
            ? widget.isFollow
                ? '我的关注'
                : '我的粉丝'
            : widget.isFollow
                ? 'Ta的关注'
                : 'Ta的粉丝'),
      ),
      body: PersonList(
        controller: _controller,
        person: people,
        onLoadCallback: _loadMore,
        onRefreshCallback: _onRefresh,
      ),
    );
  }
}
