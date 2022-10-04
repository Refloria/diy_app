// search_user_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/person_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SearchUserPage extends StatefulWidget {
  final String searchWord;
  const SearchUserPage({Key key, this.searchWord}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage>
    with AutomaticKeepAliveClientMixin {
  var currentPage = 0;
  var pageSize = 20;
  List<Widget> people = [];
  EasyRefreshController _controller = EasyRefreshController();
  bool _isEmpty = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (widget.searchWord != null && widget.searchWord != '') {
      _onRefresh();
    }
  }

  @override
  void didUpdateWidget(covariant SearchUserPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchWord != widget.searchWord) {
      _controller.callRefresh();
    }
  }

  Future<void> _loadMore() async {
    if (widget.searchWord == null || widget.searchWord == '') return;
    currentPage++;
    Map<String, dynamic> result =
        await HttpRequest.post('/getUserPageList', data: {
      'page': {'current': currentPage, 'size': pageSize},
      'searchWord': widget.searchWord
    });
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
          isFollowItem: false,
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
    super.build(context);
    return PersonList(
      controller: _controller,
      person: people,
      onLoadCallback: _loadMore,
      onRefreshCallback: _onRefresh,
      firstRefresh: false,
    );
  }
}
