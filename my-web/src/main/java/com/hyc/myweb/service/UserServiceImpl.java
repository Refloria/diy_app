package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.vo.UserVo;
import com.hyc.myweb.mapper.UserMapper;
import com.hyc.myweb.bean.po.User;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("userService")
@AllArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Autowired
    private final UserMapper userMapper;

    @Override
    public boolean isExist(String username) {
        User user = getByName(username);
        return null != user;
    }

    @Override
    public User getByName(String username) {
        return userMapper.selectByName(username);
    }

    @Override
    public User getByNameAndPassword(String username, String password) {
        return userMapper.selectByNameAndPassword(username, password);
    }

    @Override
    public void add(User user) {
        userMapper.insert(user);
    }

    @Override
    public List<String> queryUserOwnedAuthority(String username){
        return userMapper.queryUserOwnedAuthority(username);
    }

    @Override
    public Page<UserVo> getUserPageList(Page<UserVo> page, String searchWord){
        if(searchWord!=null){
            return page.setRecords(userMapper.getUserPageListWithinSearchWord(page,searchWord));
        } else {
            return page;
        }
    }
}
