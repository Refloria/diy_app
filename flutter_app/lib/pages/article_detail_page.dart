// article_detail_page.dart
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_bus.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/iconfont.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/comment_item.dart';
import 'package:flutter_app/widgets/my_quill_editor.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDetailPage extends StatefulWidget {
  /// 文章id
  final int articleId;

  /// 作者id
  final int authorId;

  /// 文章标题
  final String articleTitle;

  /// 作者头像url
  final String authorPicUrl;

  /// 作者昵称
  final String authorName;

  ArticleDetailPage({
    Key key,
    this.articleId,
    this.articleTitle,
    this.authorId,
    this.authorPicUrl,
    this.authorName,
  }) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  QuillController _contentController;

  /// 是否关注作者
  bool _isFollow = false;

  /// 是否点赞
  bool _isFavorite = false;

  /// 文章标题
  String _articleTitle;

  /// 作者id
  int _authorId;

  /// 作者头像url
  String _authorPicUrl;

  /// 作者昵称
  String _authorName;

  /// 点赞数量
  int _favoriteAmount = 0;

  /// 评论列表
  List<Widget> _commentList = [];

  int _articleId, _userId;

  int _commentPage = 0, _commentPageSize = 5;
  EasyRefreshController _refreshController = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  final GlobalKey _commentTitleKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _contentController = QuillController.basic();
    _articleId = widget.articleId;
    eventBus.on<ReplyEvent>().listen((event) {
      print(event.toString());
      if (mounted) {
        _showCommentBar(
          context,
          commentId: event.commentId,
          quoteReplyId: event.quoteReplyId,
          replyUserNickname: event.replyUserNickname,
        );
      }
    });
    // _requestArticleDetail();
  }

  /// 获取文章标题、内容，作者头像、昵称
  Future<void> _requestArticleDetail() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('user_id');
    final Map<String, dynamic> result = await HttpRequest.post(
      '/loadArticleDetail',
      data: {'id': widget.articleId},
    );
    if (result['code'] == 200) {
      Map<String, dynamic> data = result['data'];
      setState(() {
        _authorId = data['authorId'];
        _authorName = data['authorNickname'];
        _authorPicUrl = data['authorPicture'];
        _articleTitle = data['title'];
        _favoriteAmount = data['favoriteAmount'];
        _isFavorite = data['isFavorite'];
        _isFollow = data['isFollow'];
        // _commentList.clear();
      });
      _loadContent(data['content']);
    } else {
      EasyLoading.showToast(result['message']);
      print('load article detail error. msg:' + result['message'] ?? '');
    }
  }

  Future<void> _refresh() async {
    _commentPage = 0;
    _commentList.clear();
    await _requestArticleDetail();
    _refreshController.finishLoad(noMore: false);
  }

  Future<void> _loadComments() async {
    _commentPage++;
    final Map<String, dynamic> result = await HttpRequest.post(
      '/getCommentPageListByArticleId',
      data: {
        'page': {'current': _commentPage, 'size': _commentPageSize},
        'id': widget.articleId
      },
    );
    List<Widget> newComments = [];
    if (result['code'] == 200) {
      for (Map<String, dynamic> c in result['data']['records']) {
        newComments.add(CommentItem(data: c));
      }
      bool isFinish = _commentPage >= result['data']['pages'];
      if (isFinish) {
        newComments.add(myListEnd());
      }
      setState(() {
        _commentList.addAll(newComments);
        _refreshController.finishLoad(noMore: isFinish);
      });
    } else {
      _commentPage--;
      EasyLoading.showToast(result['message']);
    }
  }

  /// 将文章内容载入到QuillEditor控件
  Future<void> _loadContent(String content) async {
    try {
      final doc = Document.fromJson(jsonDecode(content));
      setState(() {
        _contentController = QuillController(
            document: doc, selection: TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      setState(() {
        _contentController = QuillController.basic();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar 作者、关注
    final appBar = PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.5,
        shadowColor: Colors.grey[350],
        backgroundColor: Colors.grey[50],
        titleSpacing: 0.0,
        title: GestureDetector(
          onTap: () =>
              MyNavigator.toPersonSocialPage(context, userId: _authorId),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatar(
                radius: 17,
                picUrl: this._authorPicUrl ?? widget.authorPicUrl,
              ),
              SizedBox(width: 10),
              Text(
                this._authorName ?? widget.authorName ?? '',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 11, 0, 11),
            child: myFlatButton(
                onPressed: _followButtonPress,
                text: _isFollow ? '已关注' : '+ 关注'),
          ),
          IconButton(icon: Icon(Iconfont.share), onPressed: () {}),
        ],
      ),
    );

    // BottomNavigationBar 点赞、评论
    final bottomNavigationBar = Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.grey[350], width: 0.3, style: BorderStyle.solid),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              onPressed: () => _showCommentBar(this.context),
              child: Row(
                children: [
                  Icon(Iconfont.write),
                  Text('说些什么吧'),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              color: Colors.grey[300],
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            constraints: BoxConstraints(maxWidth: 30.0),
            icon: Icon(
                _isFavorite ? Iconfont.love_filled : Iconfont.love_outline),
            color: _isFavorite ? Colors.redAccent[400] : Colors.black,
            onPressed: _favoriteButtonPress,
            padding: EdgeInsets.all(0.0),
          ),
          Text('点赞 $_favoriteAmount'),
          SizedBox(width: 10),
          IconButton(
            constraints: BoxConstraints(maxWidth: 30.0),
            icon: Icon(Icons.message),
            color: Colors.black,
            onPressed: _scrollToComment,
            padding: EdgeInsets.all(0.0),
          ),
        ],
      ),
    );

    return Scaffold(
      // key: globalKey,
      appBar: appBar,
      body: Scrollbar(
        controller: _scrollController,
        radius: Radius.circular(8.0),
        child: EasyRefresh(
          controller: _refreshController,
          scrollController: _scrollController,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                    Text(
                      this._articleTitle ?? widget.articleTitle ?? '',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    MyQuillEditor(
                      _contentController,
                      // placeholder: 'Loading...',
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      focusNode: FocusNode(),
                      scrollController: ScrollController(),
                      scrollable: false,
                      readOnly: true,
                    ),
                    Divider(height: 41),
                    Text('评论',
                        key: _commentTitleKey,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20),
                  ] +
                  _commentList,
            ),
          ),
          firstRefresh: true,
          onLoad: _loadComments,
          onRefresh: _refresh,
        ),
      ),
      floatingActionButton: OutlinedButton(
        child: Icon(Icons.arrow_upward_rounded),
        onPressed: () => _scrollController.animateTo(0,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            CircleBorder(side: BorderSide(color: Colors.grey, width: 0.5)),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(this.context).scaffoldBackgroundColor.withOpacity(0.8),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.grey),
          overlayColor: MaterialStateProperty.all(Colors.grey[200]),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  /// 关注按钮点击
  void _followButtonPress() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? '';
    Map<String, dynamic> result;
    final Map<String, dynamic> data = {
      'followUserId': _authorId,
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
      // eventBus.fire(FollowEvent());
    }
  }

  /// 点赞按钮点击
  void _favoriteButtonPress() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id') ?? '';
    Map<String, dynamic> result;
    final Map<String, dynamic> data = {
      'articleId': widget.articleId,
      'userId': userId
    };

    if (_isFavorite) {
      result = await HttpRequest.post('/cancelFavorite', data: data);
    } else {
      result = await HttpRequest.post('/favorite', data: data);
    }
    if (result['code'] == 200) {
      setState(() {
        _isFavorite = !_isFavorite;
        _favoriteAmount = _favoriteAmount + (_isFavorite ? 1 : -1);
      });
    }
  }

  /// 刷新评论
  Future<void> _refreshComment() async {
    _commentPage = 0;
    setState(() {
      _commentList.clear();
    });
    await _loadComments();
  }

  /// 滚动到评论
  void _scrollToComment() {
    if (_commentList.length <= 0) {
      _refreshController.callLoad();
      return;
    }
    RenderBox box = _commentTitleKey.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    double animatHeight = 0.0;
    if (offset.dy == MediaQueryData.fromWindow(window).padding.top + 60.0)
      return;
    animatHeight = _scrollController.offset +
        offset.dy -
        MediaQueryData.fromWindow(window).padding.top -
        60.0;
    double maxScroll = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      animatHeight <= maxScroll ? animatHeight : maxScroll,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  /// 弹出评论输入框
  void _showCommentBar(BuildContext context,
      {int commentId, int quoteReplyId, String replyUserNickname}) {
    String hintText =
        replyUserNickname == null ? '说些什么吧' : '回复 $replyUserNickname ：';
    showModalBottomSheet(
      context: context,
      builder: (context) => _setupCommentBar(context,
          hintText: hintText, commentId: commentId, quoteReplyId: quoteReplyId),
    );
  }

  /// 评论输入框
  Widget _setupCommentBar(BuildContext context,
      {String hintText, int commentId, int quoteReplyId}) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(top: BorderSide(color: Colors.grey[300], width: 0.5))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: TextField(
                autofocus: true,
                controller: _commentController,
                decoration: InputDecoration(
                  isCollapsed: true,
                  enabledBorder: null,
                  disabledBorder: null,
                  contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                  hintText: hintText ?? '',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 15),
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => _doneInput(),
                minLines: 1,
                maxLines: 10,
              ),
            ),
          ),
          myFlatButton(
            onPressed: () =>
                _doneInput(commentId: commentId, quoteReplyId: quoteReplyId),
            text: '发送',
          ),
        ],
      ),
    );
  }

  /// 完成输入
  _doneInput({int commentId, int quoteReplyId}) async {
    String text = _commentController.text;
    if (text == null || text.length <= 0) {
      Navigator.of(context).pop();
      EasyLoading.showToast('内容不能为空');
      return;
    }
    Map<String, dynamic> result;
    if (commentId == null) {
      result = await HttpRequest.post('/saveComment',
          data: {'articleId': _articleId, 'userId': _userId, 'content': text});
    } else {
      result = await HttpRequest.post(
        '/saveReply',
        data: {
          'commentId': commentId,
          'userId': _userId,
          'content': text,
          'quoteReplyId': quoteReplyId
        },
      );
    }
    if (result['code'] == 200) {
      _commentController.text = "";
      Navigator.of(context).pop();
      await _refreshComment();
      _scrollToComment();
    } else {
      EasyLoading.showToast(result['message']);
    }
  }
}
