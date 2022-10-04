// article_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/article_list.dart';
import 'package:flutter_app/widgets/my_widgets.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: myAppBar(title: Text('作品列表'), actions: [
        IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              MyNavigator.toSearchPage(context);
            })
      ]),
      body: ArticleList(editable: false),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
