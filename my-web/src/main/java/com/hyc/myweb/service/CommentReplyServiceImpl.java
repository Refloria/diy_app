package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.po.CommentReply;
import com.hyc.myweb.bean.vo.CommentReplyVo;
import com.hyc.myweb.mapper.CommentReplyMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("commentReplyService")
@AllArgsConstructor
public class CommentReplyServiceImpl extends ServiceImpl<CommentReplyMapper, CommentReply> implements CommentReplyService {

    @Autowired
    private final CommentReplyMapper replyMapper;

    @Override
    public Page<CommentReplyVo> selectReplyByCommentId(Page<CommentReplyVo> page, Integer commentId) {
        return page.setRecords(replyMapper.selectReplyByCommentId(page,commentId));
    }
}
