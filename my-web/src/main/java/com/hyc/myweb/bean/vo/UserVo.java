package com.hyc.myweb.bean.vo;

import com.hyc.myweb.bean.po.User;
import lombok.Data;

import java.io.Serializable;


@Data
public class UserVo implements Serializable {
    private Integer id;
    private String username;
    private String introduction;
    private String picture;
    private String nickname;
    private String sex;
    private String birthday;
    private Integer follows;
    private Integer articles;
    private Integer fans;
    private Boolean isFollow;
    private String token;
    private String refreshToken;

    public void copyFromUser(User user) {
        setId(user.getId());
        setNickname(user.getNickname());
        setPicture(user.getPicture());
        setUsername(user.getUsername());
        setSex(user.getSex());
        setIntroduction(user.getIntroduction());
        setBirthday(user.getBirthday());
    }
}
