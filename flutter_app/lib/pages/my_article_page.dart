import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_bus.dart';
import 'package:flutter_app/widgets/article_list.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyArticlePage extends StatefulWidget {
  final int userId;
  final int articleState; // 文章状态 0待审核 1上架 2下架
  const MyArticlePage(this.userId, {Key key, this.articleState = 1})
      : super(key: key);

  @override
  _MyArticlePageState createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    eventBus.on<ArticleStateChangeEvent>().listen((event) {
      if (mounted && event.articleState == widget.articleState)
        _controller.callRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (widget.articleState) {
      case 0:
        title = '待审核作品';
        break;
      case 2:
        title = '已下架作品';
        break;
      default:
        title = '我的作品';
        break;
    }

    return Scaffold(
      appBar: myAppBar(title: Text(title)),
      body: ArticleList(
        controller: _controller,
        editable: true,
        userId: widget.userId,
        articleState: widget.articleState,
      ),
    );
  }
}
