package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.po.Comment;
import com.hyc.myweb.bean.vo.CommentReplyVo;
import com.hyc.myweb.bean.vo.CommentVo;
import com.hyc.myweb.mapper.CommentMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("commentService")
@AllArgsConstructor
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

    @Autowired
    private final CommentMapper commentMapper;

    @Override
    public Page<CommentVo> selectCommentByArticleId(Page<CommentVo> page, Integer articleId) {
        return page.setRecords(commentMapper.selectCommentsByArticleId(page, articleId));
    }

//    @Override
//    public Page<CommentReplyVo> selectReplyByCommentId(Page<CommentReplyVo> page, Integer commentId) {
//        return page.setRecords(commentMapper.selectReplyByCommentId(page,commentId));
//    }
}
