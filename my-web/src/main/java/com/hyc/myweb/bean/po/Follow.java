package com.hyc.myweb.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@TableName(value = "follow")
@Data
public class Follow implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)//指定自增策略
    private Integer id;

    private Integer userId;
    private Integer followUserId;
    private String time;
}
