package com.hyc.myweb.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "article")
@Data
public class Article implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String title;
    private String content;
    private String coverPic;
    private Integer userId;
    private String publishTime;
    private String lastEditTime;
    private Integer state;
    private Boolean recommend;
}
