package com.hyc.myweb.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hyc.myweb.bean.po.Favorite;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

@Repository
public interface FavoriteMapper extends BaseMapper<Favorite> {

    @Select("select * from favorite where user_id = #{userId} and article_id = #{articleId}")
    Favorite selectByUserIdAndArticleId(@Param("userId") Integer userId, @Param("articleId") Integer articleId);


    @Select("select count(id) from favorite where article_id = #{articleId}")
    Integer countLike(@Param("articleId") Integer articleId);

    @Delete("delete from favorite where user_id = #{userId} and article_id = #{articleId}")
    boolean deleteByUserIdAndArticleId(@Param("userId") Integer userId, @Param("articleId") Integer articleId);
}
