package com.hyc.myweb.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.po.Follow;
import com.hyc.myweb.bean.vo.UserVo;
import com.hyc.myweb.mapper.FollowMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service("followService")
@AllArgsConstructor
public class FollowServiceImpl extends ServiceImpl<FollowMapper, Follow> implements FollowService {
    @Autowired
    private final FollowMapper followMapper;

    public Page<UserVo> getFollowPageList(Page<UserVo> page, Integer userId) {
        return page.setRecords(followMapper.getFollowPageList(page, userId));
    }

    public Page<UserVo> getFansPageList(Page<UserVo> page, Integer followUserId) {
        return page.setRecords(followMapper.getFansPageList(page, followUserId));
    }

    public Follow getByUserIdAndFollowUserId(Integer userId, Integer followUserId) {
        return followMapper.selectByUserIdAndFollowUserId(userId, followUserId);
    }

    public Integer countFollow(Integer userId) {
        return followMapper.countFollow(userId);
    }

    public Integer countFans(Integer followUserId) {
        return followMapper.countFans(followUserId);
    }

    public boolean saveIfNotExist(Follow follow) {
        if (getByUserIdAndFollowUserId(follow.getUserId(), follow.getFollowUserId()) != null)
            return false;

        // 获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        follow.setTime(time);
        return save(follow);
    }

    public boolean removeByUserIdAndFollowUserId(Integer userId, Integer followUserId) {
        return followMapper.deleteByUserIdAndFollowUserId(userId,followUserId);
    }
}
