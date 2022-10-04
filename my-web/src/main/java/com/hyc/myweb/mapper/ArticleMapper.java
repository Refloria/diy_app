package com.hyc.myweb.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Article;
import com.hyc.myweb.bean.vo.ArticleVo;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleMapper extends BaseMapper<Article> {

    @Select({"select a.id, a.title, a.cover_pic, a.content, a.publish_time, a.user_id, u.nickname, u.picture",
            "from article a",
            "inner join user u on u.id=a.user_id",
            "where a.id = #{id}"})
    @Results(id = "articleVo", value = {
            @Result(column = "id", property = "id"),
            @Result(column = "title", property = "title"),
            @Result(column = "content", property = "content"),
            @Result(column = "cover_pic", property = "coverPic"),
            @Result(column = "user_id", property = "userId"),
            @Result(column = "nickname", property = "userNickname"),
            @Result(column = "picture", property = "userPicture"),
            @Result(column = "publish_time", property = "publishTime", jdbcType = JdbcType.DATETIMEOFFSET, javaType = String.class)
    })
    ArticleVo selectArticleById(@Param("id") Integer id);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = #{state}) as a",
            "inner join user u on u.id=a.user_id"})
    @Results(id = "articleBrief", value = {
            @Result(column = "id", property = "id"),
            @Result(column = "title", property = "title"),
            @Result(column = "cover_pic", property = "coverPic"),
            @Result(column = "nickname", property = "userNickname"),
            @Result(column = "picture", property = "userPicture"),
            @Result(column = "publish_time", property = "publishTime", jdbcType = JdbcType.DATETIMEOFFSET, javaType = String.class)
    })
    List<ArticleVo> getArticles(Page<ArticleVo> page, @Param("state") Integer state);

    @Select({"<script>",
            "select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * ",
            "<foreach collection='searchWords' item='searchWord' separator='+' open=', (' close=') as key_weight'>",
            "(if (title like concat('%',#{searchWord},'%'), 1, 0))",
            "</foreach>",
            "from article where state = #{state} ) as a",
            "inner join user u on u.id = a.user_id",
            "where key_weight > 0",
//            "order by key_weight desc",
            "</script>"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithinSearchWord(Page<ArticleVo> page, @Param("state") Integer state,
                                                @Param("searchWords") List<String> searchWords);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = 1) as a",
            "inner join user u on u.id = a.user_id",
            "left join (select article_id, count(id) as favorites from favorite group by article_id) as f on f.article_id = a.id"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithFavorites(Page<ArticleVo> page);

    @Select({"<script>",
            "select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * ",
            "<foreach collection='searchWords' item='searchWord' separator='+' open=', (' close=') as key_weight'>",
            "(if (title like concat('%',#{searchWord},'%'), 1, 0))",
            "</foreach>",
            "from article where state = 1 ) as a",
            "inner join user u on u.id = a.user_id",
            "left join (select article_id, count(id) as favorites from favorite group by article_id) as f on f.article_id = a.id",
            "where key_weight > 0",
            "</script>"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithFavoritesWithinSearchWord(Page<ArticleVo> page, @Param("searchWords") List<String> searchWords);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = 1) as a",
            "inner join user u on u.id = a.user_id",
            "left join (select count(id) as comments, article_id from comment group by article_id) as c on a.id = c.article_id"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithComments(Page<ArticleVo> page);

    @Select({"<script>",
            "select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * ",
            "<foreach collection='searchWords' item='searchWord' separator='+' open=', (' close=') as key_weight'>",
            "(if (title like concat('%',#{searchWord},'%'), 1, 0))",
            "</foreach>",
            "from article where state = 1 ) as a",
            "inner join user u on u.id = a.user_id",
            "left join (select article_id, count(id) as comments from comment group by article_id) as c on a.id = c.article_id",
            "where key_weight > 0",
            "</script>"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithCommentsWithinSearchWord(Page<ArticleVo> page, @Param("searchWords") List<String> searchWords);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = #{state}) as a",
            "inner join user u on u.id=a.user_id",
            "where u.id = #{userId}"})
    @ResultMap("articleBrief")
    List<ArticleVo> getUserArticles(Page<ArticleVo> page, @Param("userId") Integer userId, @Param("state") Integer state);

    @Select("select count(id) from article where user_id = #{userid} and state = 1")
    Integer countUserArticles(Integer userId);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from follow where user_id = #{userId}) as f",
            "inner join (select * from article where state = 1) as a on f.follow_user_id=a.user_id",
            "inner join user u on u.id = f.follow_user_id",
            "order by publish_time desc"})
    @ResultMap("articleBrief")
    List<ArticleVo> getFollowArticles(Page<ArticleVo> page, @Param("userId") Integer userId);

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = 1) as a",
            "inner join user u on u.id=a.user_id",
            "where a.recommend = 1"})
    @ResultMap("articleBrief")
    List<ArticleVo> getRecommendArticles();

    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * from article where state = 1) as a",
            "inner join user u on u.id=a.user_id",
            "where recommend = #{recommend}"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithRecommend(Page<ArticleVo> page, @Param("recommend") Boolean recommend);

    @Select({"<script>",
            "select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
            "from (select * ",
            "<foreach collection='searchWords' item='searchWord' separator='+' open=', (' close=') as key_weight'>",
            "(if (title like concat('%',#{searchWord},'%'), 1, 0))",
            "</foreach>",
            "from article where state = 1 ) as a",
            "inner join user u on u.id = a.user_id",
            "where key_weight > 0 and recommend = #{recommend}",
            "</script>"})
    @ResultMap("articleBrief")
    List<ArticleVo> getArticlesWithRecommendWithinSearchWord(Page<ArticleVo> page, @Param("recommend") Boolean recommend, @Param("searchWords") List<String> searchWord);

//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state = 1) as a",
//            "inner join user u on u.id = a.user_id",
//            "inner join (select article_id, count(id) as favorites from favorite group by article_id) as f on f.article_id = a.id",
//            "order by f.favorites desc, a.publish_time desc"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getArticlePageListOrderByFavorites(Page<ArticleVo> page);
//
//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state = 1 and title like concat('%',#{searchWord},'%')) as a",
//            "inner join user u on u.id = a.user_id",
//            "inner join (select article_id, count(id) as favorites from favorite group by article_id) as f on f.article_id = a.id",
//            "order by f.favorites desc, a.publish_time desc"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getArticlePageListOrderByFavoritesWithinSearchWord(Page<ArticleVo> page, String searchWord);
//
//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state = 1) as a",
//            "inner join user u on u.id = a.user_id",
//            "inner join (select count(id) as comments, article_id from comment group by article_id) as c on a.id = c.article_id",
//            "order by c.comments desc, a.publish_time desc"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getArticlePageListOrderByComments(Page<ArticleVo> page);
//
//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state = 1) as a",
//            "inner join user u on u.id=a.user_id",
//            "where a.recommend = 1"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getRecommendArticles();
//
//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state = 1) as a",
//            "inner join user u on u.id=a.user_id",
//            "where recommend = #{recommend}"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getArticlePageListWithRecommend(Page<ArticleVo> page, Boolean recommend);
//
//    @Select({"select a.id, a.title, a.cover_pic, a.publish_time, u.nickname, u.picture",
//            "from (select * from article where state 1) as a",
//            "inner join user u on u.id=a.user_id",
//            "where recommend = #{recommend} and a.title like concat('%',#{searchWord},'%')"})
//    @ResultMap("articleBrief")
//    List<ArticleVo> getArticlePageListWithRecommendWithinSearchWord(Page<ArticleVo> page, Boolean recommend, String searchWord);
}
