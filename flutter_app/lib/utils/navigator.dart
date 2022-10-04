import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/bottom_navigation_widget.dart';
import 'package:flutter_app/pages/article_detail_page.dart';
import 'package:flutter_app/pages/edit_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/fans_follow_page.dart';
import 'package:flutter_app/pages/my_article_page.dart';
import 'package:flutter_app/pages/person_detail_setting_page.dart';
import 'package:flutter_app/pages/person_social_page.dart';
import 'package:flutter_app/pages/register_page.dart';
import 'package:flutter_app/pages/search_page.dart';

class MyNavigator {
  static Future<dynamic> toRootPage(BuildContext context) async {
    return await Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => BottomNavigationWidget()));
  }

  static Future<dynamic> toLoginPage(BuildContext context) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  static Future<dynamic> toRegisterPage(context) async {
    return await Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => RegisterPage()),
    );
  }

  static Future<dynamic> toArticleDetailPage(BuildContext context,
      {int articleId,
      String title,
      String authorPicUrl,
      String authorName}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ArticleDetailPage(
          articleId: articleId,
          articleTitle: title,
          authorName: authorName,
          authorPicUrl: authorPicUrl,
        ),
      ),
    );
  }

  static Future<dynamic> toArticleEditPage(BuildContext context,
      {int articleId, String title, String coverUrl}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EditPage(
          articleId: articleId,
          title: title,
          coverUrl: coverUrl,
        ),
      ),
    );
  }

  static Future<dynamic> toMyArticlePage(BuildContext context,
      {int userId, int articleState = 1}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) =>
              MyArticlePage(userId, articleState: articleState)),
    );
  }

  static Future<dynamic> toFansOrFollowPage(context,
      {int userId, bool isFollow}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => FansFollowPage(
          userId: userId,
          isFollow: isFollow,
        ),
      ),
    );
  }

  static Future<dynamic> toPersonDetailSettingPage(context,
      {int userId}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => PersonDetailSettingPage(
          userId: userId,
        ),
      ),
    );
  }

  static Future<dynamic> toPersonSocialPage(context, {int userId}) async {
    return await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => PersonSocialPage(userId: userId),
      ),
    );
  }

  static Future<dynamic> toSearchPage(context) async {
    return await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => SearchPage()));
  }

  static void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
