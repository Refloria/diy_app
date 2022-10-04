package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.Favorite;

public interface FavoriteService extends IService<Favorite> {

    Favorite getByUserIdAndArticleId(Integer userId, Integer articleId);

    Integer countFavorite(Integer articleId);

    boolean saveIfNotExist(Favorite like);

    boolean removeByUserIdAndArticleId(Integer userId, Integer articleId);
}
