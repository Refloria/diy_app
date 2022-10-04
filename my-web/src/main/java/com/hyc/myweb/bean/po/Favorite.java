package com.hyc.myweb.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "favorite")
@Data
public class Favorite implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)//指定自增策略
    private Integer id;

    private Integer userId;
    private Integer articleId;
    private String time;
}
