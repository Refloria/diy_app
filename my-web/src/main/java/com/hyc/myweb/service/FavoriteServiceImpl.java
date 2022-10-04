package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.po.Favorite;
import com.hyc.myweb.mapper.FavoriteMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service("likeService")
@AllArgsConstructor
public class FavoriteServiceImpl extends ServiceImpl<FavoriteMapper, Favorite> implements FavoriteService {
    @Autowired
    private final FavoriteMapper favoriteMapper;


    public Favorite getByUserIdAndArticleId(Integer userId, Integer articleId){
        return favoriteMapper.selectByUserIdAndArticleId(userId,articleId);
    }

    public Integer countFavorite(Integer articleId){
        return favoriteMapper.countLike(articleId);
    }

    public boolean saveIfNotExist(Favorite like){
        if(getByUserIdAndArticleId(like.getUserId(),like.getArticleId())!=null)
            return false;
        // 获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        like.setTime(time);
        return save(like);
    }

    public boolean removeByUserIdAndArticleId(Integer userId, Integer articleId){
        return favoriteMapper.deleteByUserIdAndArticleId(userId,articleId);
    }
}
