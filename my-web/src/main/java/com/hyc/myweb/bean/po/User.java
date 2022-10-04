package com.hyc.myweb.bean.po;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;

@TableName(value = "user")
@Data
public class User implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)//指定自增策略
    private Integer id;

    private String username;
    private String password;
    private String introduction;
    private String sex;
    private String birthday;
    private String picture;
    private String nickname;
    private String lastTime;
    private String registerTime;
}
