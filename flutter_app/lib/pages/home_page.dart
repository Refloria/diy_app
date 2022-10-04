// home_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/article_list_item.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> _bannerItems = [],
      _latest = [],
      _mostFavorite = [],
      _mostCommend = [];
  int _count = 0;
  EasyRefreshController _refreshController = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _loadBannerItems();
  }

  void _loadBannerItems() async {
    Map<String, dynamic> result = await HttpRequest.post(
      '/getArticlePageList',
      data: {
        'page': {'current': 1, 'size': 5}
      },
    );
    setState(() {
      List<dynamic> records = result['data']['records'];
      _bannerItems = records;
      _latest = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: myAppBar(
        title: Row(
          children: [
            Expanded(
              child: FlatButton(
                colorBrightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                color: Colors.blue[600],
                child: Row(children: [Icon(Icons.search_rounded)]),
                onPressed: () {
                  MyNavigator.toSearchPage(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        radius: Radius.circular(8.0),
        child: EasyRefresh.custom(
          scrollController: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  switch (index) {
                    case 0:
                      return ArticleBanner(items: _bannerItems);
                    case 1:
                      return HorizontalArticleList(
                          title: '最新发布', items: _latest);
                    case 2:
                      return HorizontalArticleList(
                          title: '点赞最多', items: _mostFavorite);
                    case 3:
                      return HorizontalArticleList(
                          title: '评论最多', items: _mostCommend);
                    default:
                      return myListEnd();
                  }
                },
                childCount: _count,
              ),
            ),
          ],
          firstRefresh: true,
          onLoad: _load,
          onRefresh: _refresh,
          controller: _refreshController,
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    _count = 0;
    _load();
  }

  Future<void> _load() async {
    Map<String, dynamic> result;
    switch (_count) {
      case 0:
        {
          result = await HttpRequest.post('/getRecommendArticles');
          if (result['code'] != 200) break;
          _bannerItems = result['data'];
          result.clear();
          result = await HttpRequest.post(
            '/getArticlePageList',
            data: {
              'page': {'current': 1, 'size': 10},
              'sortingColumn': 'publishTime'
            },
          );
          if (result['code'] != 200) break;
          _latest = result['data']['records'];

          setState(() {
            _count += 2;
            _refreshController.finishLoad(noMore: false);
          });
          // break;
          //   }
          // case 2:
          //   {
          result = await HttpRequest.post(
            '/getArticlePageList',
            data: {
              'page': {'current': 1, 'size': 10},
              'sortingColumn': 'favorites'
            },
          );
          if (result['code'] != 200) break;
          _mostFavorite = result['data']['records'];
          setState(() {
            _count++;
          });
          break;
        }
      case 3:
        {
          result = await HttpRequest.post(
            '/getArticlePageList',
            data: {
              'page': {'current': 1, 'size': 10},
              'sortingColumn': 'comments'
            },
          );
          if (result['code'] != 200) break;
          _mostCommend = result['data']['records'];
          setState(() {
            _count++;
            _refreshController.finishLoad(noMore: true);
          });
          break;
        }
      default:
        break;
    }
    if (result['code'] != 200) {
      EasyLoading.showToast(result['message']);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class HorizontalArticleList extends StatelessWidget {
  final String title;

  final List<dynamic> items;

  const HorizontalArticleList({Key key, this.items, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.6,
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            height: 220,
            child: ListView.builder(
              itemBuilder: (context, index) {
                Map<String, dynamic> record = items[index];
                return ArticleListItemHorizontal(
                  articleId: record['id'],
                  articleTitle: record['title'],
                  coverPicUrl: record['coverPic'],
                  authorPicUrl: record['userPicture'],
                  authorName: record['userNickname'],
                  // publishTime: record['publishTime'].toString().split(' ')[0],
                );
              },
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class ArticleBanner extends StatelessWidget {
  final List<dynamic> items;

  const ArticleBanner({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            if (this.items == null || this.items.length <= index) {
              return Image.network(
                "http://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              );
            } else {
              return Image.network(items[index]['coverPic'], fit: BoxFit.cover);
            }
          },
          itemCount: (items?.length) ?? 1,
          pagination: SwiperPagination(
            margin: EdgeInsets.all(5.0),
            builder: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
                return Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          items != null && items.length > config.activeIndex
                              ? items[config.activeIndex]['title']
                              : '',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      DotSwiperPaginationBuilder(
                        color: Color(0x7fffffff), // 50%透明度 白色
                        activeColor: Colors.white,
                      ).build(context, config),
                    ],
                  ),
                );
              },
            ),
          ),
          autoplay: true,
          autoplayDelay: 5000,
          onTap: (index) {
            if (items != null && items.length > index) {
              MyNavigator.toArticleDetailPage(context,
                  articleId: items[index]['id'], title: items[index]['title']);
            } else {
              print('banner index: $index');
            }
          },
        ),
      ),
    );
  }
}
