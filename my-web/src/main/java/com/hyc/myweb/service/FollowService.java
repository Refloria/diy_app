package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.Follow;
import com.hyc.myweb.bean.vo.UserVo;

public interface FollowService extends IService<Follow> {

    Page<UserVo> getFollowPageList(Page<UserVo> page, Integer userId);

    Page<UserVo> getFansPageList(Page<UserVo> page, Integer followUserId);

    Follow getByUserIdAndFollowUserId(Integer userId, Integer followUserId);

    Integer countFollow(Integer userId);

    Integer countFans(Integer followUserId);

    boolean saveIfNotExist(Follow follow);

    boolean removeByUserIdAndFollowUserId(Integer userId, Integer followUserId);
}
