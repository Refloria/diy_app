// comment_item.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_bus.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommentItem extends StatefulWidget {
  final Map<String, dynamic> data;
  CommentItem({Key key, this.data}) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  int _id, _articleId, _userId, _replyAmount;
  String _userNickname, _userPicture, _content, _time;
  List<dynamic> _reply;
  List<Widget> _replyList = [];
  int _replyPage = 0, _size = 5;
  bool _isFinish = false;

  @override
  void initState() {
    super.initState();
    _id = widget.data['id'];
    _articleId = widget.data['articleId'];
    _userId = widget.data['userId'];
    _userNickname = widget.data['userNickname'];
    _userPicture = widget.data['userPicture'];
    _content = widget.data['content'];
    _time = widget.data['time'];
    _time = _time.substring(0, _time.indexOf('.'));
    _replyAmount = widget.data['replyAmount'];
    _reply = widget.data['reply'];
    _isFinish = _replyAmount <= 1;
    if (_replyAmount > 0) _setupReplyList(_reply);
  }

  _setupReplyList(List<dynamic> reply) {
    List<Widget> moreReply = [];
    for (Map<String, dynamic> r in reply) {
      moreReply.add(ReplyItem(data: r));
    }
    if (!_isFinish) {
      moreReply.add(
        Container(
          margin: EdgeInsets.only(left: 30),
          child: TextButton(
            onPressed: () {
              print('click');
              _loadMoreReply();
            },
            child: Text('加载更多'),
            style: ButtonStyle(
              //设置按钮内边距
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              //设置按钮的大小
              minimumSize: MaterialStateProperty.all(Size(50, 20)),
              //设置水波纹颜色
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
        ),
      );
    }
    setState(() {
      if (_replyPage <= 1) {
        _replyList.clear();
      } else {
        _replyList.removeLast();
      }
      _replyList.addAll(moreReply);
    });
  }

  void _loadMoreReply() async {
    print('clicked');
    _replyPage++;
    final Map<String, dynamic> result = await HttpRequest.post(
      '/getReplyPageListByCommentId',
      data: {
        'page': {'current': _replyPage, 'size': _size},
        'id': _id
      },
    );
    if (result['code'] == 200) {
      _isFinish = _replyPage >= result['data']['pages'];
      _setupReplyList(result['data']['records']);
    } else {
      EasyLoading.showToast(result['message']);
      _replyPage--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
          radius: 15,
          picUrl: _userPicture,
          onTap: () => MyNavigator.toPersonSocialPage(context, userId: _userId),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  Text(
                    _userNickname,
                    style: TextStyle(
                        color: Colors.grey, fontSize: 14, height: 1.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    child: Text(_content, style: TextStyle(height: 1.5)),
                    onTap: () {
                      print('tap comment');
                      eventBus.fire(
                          ReplyEvent(_id, replyUserNickname: _userNickname));
                    },
                  ),
                  Text(
                    _time,
                    style: TextStyle(
                        color: Colors.grey, fontSize: 13, height: 1.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] +
                _replyList +
                <Widget>[Divider(height: 31)],
          ),
        )
      ],
    );
  }
}

class ReplyItem extends StatefulWidget {
  final Map<String, dynamic> data;
  ReplyItem({Key key, this.data}) : super(key: key);

  @override
  _ReplyItemState createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  int _id, _commentId, _userId, _quoteReplyId;
  String _userNickname, _userPicture, _content, _time, _quoteReplyUserNickname;

  @override
  void initState() {
    super.initState();
    _id = widget.data['id'];
    _commentId = widget.data['commentId'];
    _userId = widget.data['userId'];
    _userNickname = widget.data['userNickname'];
    _userPicture = widget.data['userPicture'];
    _content = widget.data['content'];
    _time = widget.data['time'];
    _time = _time.substring(0, _time.indexOf('.'));
    _quoteReplyId = widget.data['quoteReplyId'];
    _quoteReplyUserNickname = widget.data['quoteReplyUserNickname'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            radius: 11,
            picUrl: _userPicture,
            onTap: () =>
                MyNavigator.toPersonSocialPage(context, userId: _userId),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userNickname,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey, height: 1.5),
                    children: (_quoteReplyId != null
                            ? <TextSpan>[
                                TextSpan(text: '回复 '),
                                TextSpan(
                                  text: _quoteReplyUserNickname,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                TextSpan(text: ' ：'),
                              ]
                            : <TextSpan>[]) +
                        <TextSpan>[
                          TextSpan(
                            text: _content,
                            style: TextStyle(color: Colors.black87),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tap reply');
                                eventBus.fire(ReplyEvent(_commentId,
                                    quoteReplyId: _id,
                                    replyUserNickname: _userNickname));
                              },
                          ),
                        ],
                  ),
                ),
                Text(
                  _time,
                  style:
                      TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(top: 10),
    );
  }
}
