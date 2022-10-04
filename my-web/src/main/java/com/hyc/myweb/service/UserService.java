package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.User;
import com.hyc.myweb.bean.vo.UserVo;

import java.util.List;

public interface UserService extends IService<User> {
    boolean isExist(String username);

    User getByName(String username);

    User getByNameAndPassword(String username, String password);

    void add(User user);

    List<String> queryUserOwnedAuthority(String username);

    Page<UserVo> getUserPageList(Page<UserVo> page, String searchWord);

}
