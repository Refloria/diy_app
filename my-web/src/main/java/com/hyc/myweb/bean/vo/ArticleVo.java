package com.hyc.myweb.bean.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.sql.Date;

@Data
public class ArticleVo implements Serializable {
    private Integer id;
    private String title;
    private String content;
    private String coverPic;
    private Integer userId;
    private String userNickname;
    private String userPicture;
    private String publishTime;
}
