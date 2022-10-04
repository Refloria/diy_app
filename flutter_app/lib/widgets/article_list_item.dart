// article_list_item
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/event_bus.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ArticleListItem extends StatelessWidget {
  final int articleId; // 文章id
  final String coverPicUrl; // 封面图片
  final String articleTitle; // 文章标题
  final String authorPicUrl; // 作者头像
  final String authorName; // 作者昵称
  final String publishTime; // 发布时间
  final bool readOnly;
  final int articleState; // 文章状态 0待审核 1上架 2下架

  const ArticleListItem(
      {Key key,
      this.articleId,
      this.coverPicUrl,
      this.articleTitle,
      this.authorPicUrl,
      this.authorName,
      this.publishTime,
      this.readOnly = true,
      this.articleState = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
      clipBehavior: Clip.antiAlias,
      // 裁剪方式
      elevation: 0,
      // 阴影高度
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: Colors.grey[200],
        highlightColor: Colors.grey[200],
        onTap: () async {
          if (this.readOnly) {
            await _toDeatilPage(context);
          } else {
            await _toEditPage(context);
          }
        },
        onLongPress: () {
          if (this.readOnly) return;
          // showMenu(
          //   context: context,
          //   position: RelativeRect.fromLTRB(0, 0, 0, 0),
          //   items: <PopupMenuEntry>[
          //     PopupMenuItem(
          //       child: TextButton(
          //         child: Text('下架'),
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //           _showOffShelfDialog(context);
          //         },
          //       ),
          //     ),
          //     PopupMenuItem(
          //       child: TextButton(
          //         child: Text('提交审核'),
          //         onPressed: () => _showSumitCheckingDialog,
          //       ),
          //     ),
          //   ],
          // );
          switch (articleState) {
            case 0:
            case 1:
              _showOffShelfDialog(context);
              break;
            case 2:
              _showSumitCheckingDialog(context);
              break;
            default:
              break;
          }
        },
        child: Row(
          children: [
            Image.network(coverPicUrl,
                fit: BoxFit.cover, width: 120, height: 100), // 封面图片
            Expanded(
              child: Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16 * 1.6 * 2,
                      child: Text(
                        articleTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ), // 标题
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserAvatar(picUrl: authorPicUrl, radius: 12), // 作者头像
                        SizedBox(width: 5),
                        Text(
                          authorName,
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ), // 作者用户名
                        Expanded(child: SizedBox()),
                        Text(
                          publishTime.split(' ')[0],
                          style: TextStyle(fontSize: 13),
                        ), // 发布时间
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showOffShelfDialog(BuildContext context) {
    myDialog(
      context,
      content: '确认要下架作品吗',
      accept: () async {
        Map<String, dynamic> result = await HttpRequest.post(
          '/takeArticleOffShelf',
          data: {
            'articles': [
              {'id': this.articleId}
            ]
          },
        );
        if (result['code'] == 200) {
          EasyLoading.showToast('下架成功');
          eventBus.fire(ArticleStateChangeEvent(this.articleState));
        } else {
          EasyLoading.showToast('下架失败');
        }
        Navigator.of(context).pop();
      },
    );
  }

  _showSumitCheckingDialog(BuildContext context) {
    myDialog(
      context,
      content: '确认要提交审核吗',
      accept: () async {
        Map<String, dynamic> result = await HttpRequest.post(
          '/submitArticleForChecking',
          data: {
            'articles': [
              {'id': this.articleId}
            ]
          },
        );
        if (result['code'] == 200) {
          EasyLoading.showToast('提交审核成功');
          eventBus.fire(ArticleStateChangeEvent(this.articleState));
        } else {
          EasyLoading.showToast('提交审核失败');
        }
        Navigator.of(context).pop();
      },
    );
  }

  _toEditPage(BuildContext context) {
    MyNavigator.toArticleEditPage(
      context,
      articleId: this.articleId,
      title: this.articleTitle,
      coverUrl: this.coverPicUrl,
    );
  }

  _toDeatilPage(BuildContext context) {
    MyNavigator.toArticleDetailPage(
      context,
      articleId: this.articleId,
      title: this.articleTitle,
      authorName: this.authorName,
      authorPicUrl: this.authorPicUrl,
    );
  }
}

/// 竖构图的文章项
class ArticleListItemHorizontal extends StatelessWidget {
  final int articleId; // 文章id
  final String coverPicUrl; // 封面图片
  final String articleTitle; // 文章标题
  final String authorPicUrl; // 作者头像
  final String authorName; // 作者昵称
  // final String publishTime; // 发布时间
  final bool readOnly;
  final int articleState; // 文章状态 0待审核 1上架 2下架

  const ArticleListItemHorizontal(
      {Key key,
      this.articleId,
      this.coverPicUrl,
      this.articleTitle,
      this.authorPicUrl,
      this.authorName,
      // this.publishTime,
      this.readOnly = true,
      this.articleState = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        // 裁剪方式
        elevation: 0,
        // 阴影高度
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          splashColor: Colors.grey[200],
          highlightColor: Colors.grey[200],
          onTap: () => MyNavigator.toArticleDetailPage(
            context,
            articleId: this.articleId,
            title: this.articleTitle,
            authorName: this.authorName,
            authorPicUrl: this.authorPicUrl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(coverPicUrl,
                  fit: BoxFit.cover, width: 150, height: 120), // 封面图片
              Container(
                height: 16 * 1.6 * 2,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  articleTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ), // 标题
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserAvatar(picUrl: authorPicUrl, radius: 12), // 作者头像
                    SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        authorName,
                        style: TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ), // 作者用户名
                    // Text(
                    //   publishTime.split(' ')[0],
                    //   style: TextStyle(fontSize: 13),
                    // ), // 发布时间
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      height: 220,
      width: 150,
    );
  }
}
