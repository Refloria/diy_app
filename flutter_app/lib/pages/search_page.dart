import 'package:flutter/material.dart';
import 'package:flutter_app/pages/search_article_page.dart';
import 'package:flutter_app/pages/search_user_page.dart';
import 'package:flutter_app/widgets/my_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TabController _tabController;

  bool _resultVisibility = false;
  String _searchWord = '', _articleSearchWord = '', _userSearchWord = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _order = 'Time Desc';
    _searchController = TextEditingController(text: _articleSearchWord);

    // 输入搜索内容时隐藏结果
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _resultVisibility) {
        setState(() {
          _resultVisibility = false;
        });
      }
    });

    // tab页切换时，另一页搜索
    _tabController.addListener(() {
      if (_resultVisibility &&
          _tabController.index == _tabController.animation.value) {
        switch (_tabController.index) {
          case 0:
            if (_articleSearchWord != _searchWord) {
              setState(() {
                _articleSearchWord = _searchWord;
              });
            }
            break;
          case 1:
            if (_userSearchWord != _searchWord) {
              setState(() {
                _userSearchWord = _searchWord;
              });
            }
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 搜索栏
    PreferredSize searchBar = myAppBar(
      title: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 5, top: 5),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                autofocus: true,
                decoration: InputDecoration(
                  isCollapsed: true,
                  enabledBorder: null,
                  disabledBorder: null,
                  contentPadding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                  hintText: "搜索一下",
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.search_rounded, color: Colors.grey[400]),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20),
                ),
                style: TextStyle(fontSize: 15),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _search();
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _search,
          child: Text('搜索', style: TextStyle(color: Colors.white)),
        ),
      ],
      titleSpacing: 0,
    );

    Widget tabBar = Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 0.5)),
      ),
      height: 45,
      child: Container(
        width: 150,
        child: TabBar(
          labelColor: Colors.black87,
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: Colors.grey,
          // indicatorColor: Theme.of(context).primaryColor,
          controller: _tabController,
          tabs: [Tab(text: '作品'), Tab(text: '用户')],
        ),
      ),
    );

    return Scaffold(
      appBar: searchBar,
      body: Visibility(
        // maintainState: true,
        visible: _resultVisibility,
        // replacement: Container(
        //   child: Center(child: Text('Searching')),
        // ),
        child: Column(
          children: [
            tabBar,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: NeverScrollableScrollPhysics(), // 禁止横向切换
                children: <Widget>[
                  SearchArticlePage(
                    searchWord: _articleSearchWord,
                  ),
                  SearchUserPage(
                    searchWord: _userSearchWord,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 搜索
  _search() {
    _searchWord = _searchController.text.trim();
    setState(() {
      _searchController.text = _searchWord;
      if (_searchWord.length <= 0) return;
      switch (_tabController.index) {
        case 0:
          _articleSearchWord = _searchController.text;
          break;
        case 1:
          _userSearchWord = _searchWord;
          break;
        default:
          return;
      }
      _resultVisibility = true;
    });
    _focusNode.unfocus();
  }
}
