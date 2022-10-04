// article_list.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/article_list_item.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticleList extends StatefulWidget {
  /// 不为null则显示该用户的文章列表，否则显示所有文章
  final int userId;

  /// 为true点击后跳转至编辑页面，为false点击后跳转至详情页面
  final bool editable;

  final int articleState; // 文章状态 0待审核 1上架 2下架

  final bool isFollowList;

  final EasyRefreshController controller;

  final bool firstRefresh;

  ArticleList(
      {Key key,
      this.userId,
      this.editable = false,
      this.isFollowList = false,
      this.controller,
      this.articleState = 1,
      this.firstRefresh = true})
      : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  var currentPage = 0;
  var pageSize = 10;
  List<Widget> articles = [];
  EasyRefreshController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? EasyRefreshController();
    _scrollController = ScrollController();
  }

  Future<void> _loadMore() async {
    currentPage++;
    Map<String, dynamic> result;
    if (!widget.isFollowList) {
      result = await HttpRequest.post(
        '/getArticlePageList',
        data: {
          'page': {'current': currentPage, 'size': pageSize},
          'userId': widget.userId,
          'articleState': widget.articleState
        },
      );
    } else {
      result = await HttpRequest.post(
        '/getFollowArticlePageList',
        data: {
          'page': {'current': currentPage, 'size': pageSize},
          'userId': widget.userId
        },
      );
    }
    if (result['code'] == 200) {
      List<Widget> moreArticles = [];
      final Map<String, dynamic> data = result['data'];
      for (var item in data['records']) {
        moreArticles.add(ArticleListItem(
          articleId: item['id'],
          articleTitle: item['title'],
          coverPicUrl: item['coverPic'],
          authorName: item['userNickname'],
          authorPicUrl: item['userPicture'],
          publishTime: item['publishTime'],
          readOnly: !widget.editable,
          articleState: widget.articleState,
        ));
      }
      if (mounted) {
        setState(() {
          articles.addAll(moreArticles);
          _controller.finishLoad(noMore: currentPage >= data['pages']);
        });
        if (currentPage >= data['pages']) {
          setState(() {
            articles.add(myListEnd());
          });
        }
      }
    } else {
      print('load article list error. msg:' + result['message'] ?? '');
      currentPage--;
    }
  }

  Future<void> _refresh() async {
    currentPage = 0;
    articles.clear();
    await _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      radius: Radius.circular(8.0),
      child: EasyRefresh(
        scrollController: _scrollController,
        controller: _controller,
        header: MaterialHeader(completeDuration: Duration(milliseconds: 500)),
        footer: MaterialFooter(),
        child:
            // SingleChildScrollView(
            //   padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            //   child:
            Wrap(
          children: articles,
        ),
        // ),
        onLoad: _loadMore,
        onRefresh: _refresh,
        firstRefresh: widget.firstRefresh,
      ),
    );
  }
}
