package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.CommentReply;
import com.hyc.myweb.bean.vo.CommentReplyVo;

public interface CommentReplyService extends IService<CommentReply> {
    Page<CommentReplyVo> selectReplyByCommentId(Page<CommentReplyVo> page, Integer commentId);
}
