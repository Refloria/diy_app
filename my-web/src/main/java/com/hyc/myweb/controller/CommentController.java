package com.hyc.myweb.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Comment;
import com.hyc.myweb.bean.po.CommentReply;
import com.hyc.myweb.bean.vo.CommentReplyVo;
import com.hyc.myweb.bean.vo.CommentVo;
import com.hyc.myweb.bean.wrapper.PageListRequest;
import com.hyc.myweb.service.CommentReplyService;
import com.hyc.myweb.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import result.Result;

import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
public class CommentController {

    @Autowired
    CommentService commentService;

    @Autowired
    CommentReplyService replyService;

    @PostMapping("/getCommentPageListByArticleId")
    public Result<Page<CommentVo>> getCommentPageListByArticleId(@RequestBody PageListRequest<CommentVo> request) {
        Page<CommentVo> p = commentService.selectCommentByArticleId(request.getPage(), request.getId());
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/getReplyPageListByCommentId")
    public Result<Page<CommentReplyVo>> getReplyPageListByCommentId(@RequestBody PageListRequest<CommentReplyVo> request) {
        Page<CommentReplyVo> p = replyService.selectReplyByCommentId(request.getPage(), request.getId());
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/saveComment")
    public Result<Object> saveComment(@RequestBody Comment comment) {
        // 获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        comment.setTime(time);

        if (commentService.save(comment)) {
            return Result.success();
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/saveReply")
    public Result<Object> saveReply(@RequestBody CommentReply reply) {
        // 获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        reply.setTime(time);

        if (replyService.save(reply)) {
            return Result.success();
        } else {
            return Result.failed();
        }
    }
}
