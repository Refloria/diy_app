package com.hyc.myweb.bean.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class CommentVo implements Serializable{
    private Integer id;
    private Integer articleId;
    private Integer userId;
    private String userNickname;
    private String userPicture;
    private String content;
    private String time;
    private Integer replyAmount;
    private List<CommentReplyVo> reply;
}
