package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.Comment;
import com.hyc.myweb.bean.vo.CommentReplyVo;
import com.hyc.myweb.bean.vo.CommentVo;


public interface CommentService extends IService<Comment> {

    Page<CommentVo> selectCommentByArticleId(Page<CommentVo> page, Integer articleId);

//    Page<CommentReplyVo> selectReplyByCommentId(Page<CommentReplyVo> page, Integer commentId);
}

