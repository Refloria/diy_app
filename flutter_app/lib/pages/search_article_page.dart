// search_article_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/article_list_item.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SearchArticlePage extends StatefulWidget {
  final String searchWord;
  const SearchArticlePage({Key key, this.searchWord}) : super(key: key);

  @override
  _SearchArticlePageState createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage>
    with AutomaticKeepAliveClientMixin {
  // String _order;
  // List<String> _orderValue = ['Time', 'Favorites'];
  int _orderIndex = 0;
  List<String> _orderText = ['相关性', '最新', '点赞数'];
  List<String> _sortingColumns = ['keyWeight', 'publishTime', 'favorites'];

  EasyRefreshController _controller = EasyRefreshController();
  int currentPage = 0, pageSize = 10;
  List<Widget> articles = [];
  ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _orderIndex = 0;
    if (widget.searchWord != null && widget.searchWord != '') {
      _refresh();
    }
  }

  @override
  void didUpdateWidget(covariant SearchArticlePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchWord != widget.searchWord) {
      _orderIndex = 0;
      _controller.callRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.grey[300], width: 0.5)),
          ),
          height: 40,
          child: Row(
            children: [
              _setupOrderButton(0),
              _setupOrderButton(1),
              _setupOrderButton(2)
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            radius: Radius.circular(8.0),
            child: EasyRefresh(
              scrollController: _scrollController,
              controller: _controller,
              header:
                  MaterialHeader(completeDuration: Duration(milliseconds: 500)),
              footer: MaterialFooter(),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Wrap(
                  children: articles,
                ),
              ),
              onLoad: _loadMore,
              onRefresh: _refresh,
              firstRefresh: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _setupOrderButton(int index) {
    return TextButton(
      child: Text(
        _orderText[index],
        style: _orderIndex == index
            ? TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)
            : TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        setState(() {
          _orderIndex = index;
        });
        _controller.callRefresh();
      },
    );
  }

  Future<void> _refresh() async {
    currentPage = 0;
    articles.clear();
    await _loadMore();
  }

  /// 加载下一页
  Future<void> _loadMore() async {
    if (widget.searchWord == null || widget.searchWord == '') return;
    currentPage++;
    Map<String, dynamic> result =
        await HttpRequest.post('/getArticlePageList', data: {
      'page': {'current': currentPage, 'size': pageSize},
      'searchWord': widget.searchWord,
      'sortingColumn': _sortingColumns[_orderIndex],
      'isDesc': true
    });

    if (result['code'] == 200) {
      List<Widget> moreArticles = [];
      final Map<String, dynamic> data = result['data'];
      for (var item in data['records']) {
        moreArticles.add(
          ArticleListItem(
              articleId: item['id'],
              articleTitle: item['title'],
              coverPicUrl: item['coverPic'],
              authorName: item['userNickname'],
              authorPicUrl: item['userPicture'],
              publishTime: item['publishTime']),
        );
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
}
