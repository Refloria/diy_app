package com.hyc.myweb.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "comment")
@Data
public class Comment implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer articleId;
    private Integer userId;
    private String content;
    private String time;
}
