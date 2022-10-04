// person_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonList extends StatelessWidget {
  final List<Widget> person;
  final EasyRefreshController controller;
  final OnLoadCallback onLoadCallback;
  final OnRefreshCallback onRefreshCallback;
  final bool firstRefresh;
  final ScrollController _scrollController = ScrollController();

  PersonList({
    Key key,
    this.person,
    this.controller,
    this.onLoadCallback,
    this.onRefreshCallback,
    this.firstRefresh = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      radius: Radius.circular(8.0),
      child: EasyRefresh(
        scrollController: _scrollController,
        controller: controller,
        header: MaterialHeader(completeDuration: Duration(milliseconds: 500)),
        footer: MaterialFooter(),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Wrap(
            children: person,
          ),
        ),
        onLoad: onLoadCallback,
        onRefresh: onRefreshCallback,
        firstRefresh: firstRefresh,
      ),
    );
  }
}

class PersonListItem extends StatefulWidget {
  /// 用户id
  final int userId;

  /// 用户头像
  final String userPic;

  /// 用户昵称
  final String nickName;

  /// 是否关注
  final bool isFollow;

  /// 是否带有关注按钮
  final bool isFollowItem;

  const PersonListItem(
      {Key key,
      this.userId,
      this.userPic,
      this.nickName,
      this.isFollowItem = true,
      this.isFollow})
      : super(key: key);

  @override
  _PersonListItemState createState() => _PersonListItemState();
}

class _PersonListItemState extends State<PersonListItem> {
  bool _isFollow;
  bool _isFollowItem;

  @override
  void initState() {
    super.initState();
    _isFollow = widget.isFollow;
    _isFollowItem = widget.isFollowItem;
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
    //  else if (result['code'] == 399) {
    //   // _gotoLogin(); // 验证token失败，重新登录
    // }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> followButton = [];
    if (_isFollowItem) {
      followButton.add(myFlatButton(
          onPressed: _followButtonPress, text: _isFollow ? '已关注' : '+ 关注'));
    }

    return InkWell(
      onTap: () =>
          MyNavigator.toPersonSocialPage(context, userId: widget.userId),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
                UserAvatar(radius: 20, borderWidth: 1, picUrl: widget.userPic),
                SizedBox(width: 10),
                Expanded(
                  child: Text(widget.nickName, overflow: TextOverflow.ellipsis),
                ),
              ] +
              followButton,
        ),
      ),
    );
  }
}
