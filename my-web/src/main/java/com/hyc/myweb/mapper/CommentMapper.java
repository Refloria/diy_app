package com.hyc.myweb.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Comment;
import com.hyc.myweb.bean.vo.CommentReplyVo;
import com.hyc.myweb.bean.vo.CommentVo;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper extends BaseMapper<Comment> {

    @Results(id = "comment", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "articleId", column = "article_id"),
            @Result(property = "userId", column = "user_id"),
            @Result(property = "userNickname", column = "nickname"),
            @Result(property = "userPicture", column = "picture"),
            @Result(property = "content", column = "content"),
            @Result(property = "time", column = "time", jdbcType = JdbcType.DATETIMEOFFSET, javaType = String.class),
            @Result(property = "replyAmount", column = "reply_amount"),
            @Result(property = "reply", javaType = List.class, many = @Many(select = "com.hyc.myweb.mapper.CommentReplyMapper.selectReplyById"), column = "reply_id")
    })
    @Select({"select c.id, c.user_id, u.nickname, u.picture, c.article_id, c.content, c.time, ifnull(r.reply_amount,0) as reply_amount, r.id as reply_id",
            "from comment as c",
            "left join (select count(id) as reply_amount, id, comment_id from comment_reply group by comment_id) as r on c.id = r.comment_id",
            "inner join user as u on u.id = c.user_id",
            "where article_id = #{articleId}"})
    List<CommentVo> selectCommentsByArticleId(Page<CommentVo> page, @Param("articleId") Integer articleId);

    @Results(id = "reply", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "commentId", column = "comment_id"),
            @Result(property = "userId", column = "user_id"),
            @Result(property = "userNickname", column = "nickname"),
            @Result(property = "userPicture", column = "picture"),
            @Result(property = "content", column = "content"),
            @Result(property = "time", column = "time", jdbcType = JdbcType.DATETIMEOFFSET, javaType = String.class),
            @Result(property = "quoteReplyId", column = "quote_reply_id"),
            @Result(property = "quoteReplyUserNickname", one = @One(select = "selectNicknameByReplyId"), column = "quote_reply_id"),
    })
    @Select({"select r.id, r.comment_id, r.user_id, u.nickname, u.picture, r.content, r.time, r.quote_reply_id",
            "from comment_reply as r",
            "inner join user as u on u.id = r.user_id",
            "where r.id = #{replyId}"
    })
    CommentReplyVo selectReplyById(@Param("replyId") Integer replyId);

    @Select({"select nickname from comment_reply as r inner join user as u on r.user_id = u.id where r.id = #{replyId}"})
    String selectNicknameByReplyId(@Param("reply_id") Integer replyId);

    @Select({"select r.id, r.comment_id, r.user_id, u.nickname, u.picture, r.content, r.time, r.quote_reply_id",
            "from comment_reply as r",
            "inner join user as u on u.id = r.user_id",
            "where r.comment_id = #{commentId}"
    })
    @ResultMap("reply")
    List<CommentReplyVo> selectReplyByCommentId(Page<CommentReplyVo> page, @Param("commentId") Integer CommentId);
}
