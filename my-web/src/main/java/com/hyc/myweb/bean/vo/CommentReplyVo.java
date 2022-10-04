package com.hyc.myweb.bean.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class CommentReplyVo implements Serializable {
    private Integer id;
    private Integer commentId;
    private Integer userId;
    private String userNickname;
    private String userPicture;
    private String content;
    private String time;
    private Integer quoteReplyId;
    private String quoteReplyUserNickname;
}
