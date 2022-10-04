// event_bus.dart
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 定义全局监听的事件类

/// 文章状态变化事件
class ArticleStateChangeEvent {
  /// 文章原本的状态
  int articleState;

  ArticleStateChangeEvent(this.articleState);
}

/// 关注或取消关注事件
class FollowEvent {
  FollowEvent();
}

/// 评论事件
class CommentEvent {
  CommentEvent();
}

/// 回复事件
class ReplyEvent {
  /// 回复的评论（这条回复属于那条评论）
  int commentId;

  /// 引用的回复（这条回复是评论下面哪条回复的回复）
  int quoteReplyId;

  /// 回复对象的昵称
  String replyUserNickname;

  ReplyEvent(this.commentId, {this.quoteReplyId, this.replyUserNickname});
}
