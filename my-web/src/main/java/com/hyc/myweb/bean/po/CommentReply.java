package com.hyc.myweb.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "comment_reply")
@Data
public class CommentReply implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer commentId;
    private Integer userId;
    private String content;
    private String time;
    private Integer quoteReplyId;
}
