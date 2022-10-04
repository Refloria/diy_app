package com.hyc.myweb.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hyc.myweb.bean.po.Article;
import com.hyc.myweb.bean.vo.ArticleVo;

import java.util.List;


public interface ArticleService extends IService<Article> {

    Integer OFF_SHELF_STATE = 2;
    Integer ON_SHELF_STATE = 1;
    Integer WAIT_CHECKING_STATE = 0;

    Page<ArticleVo> getArticlePageList(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, Integer articleState, Integer userId);

    Page<ArticleVo> getArticlePageList(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, Integer articleState, Integer userId, String searchWord);

//    Page<ArticleVo> getUserArticlePageList(Page<ArticleVo> page, Integer userId, String sortingColumn, Boolean isDesc, Integer articleState);

    ArticleVo getArticleById(Integer id);

    Boolean saveOrUpdateArticle(Article article);

    Integer countArticles(Integer authorId);

    Page<ArticleVo> getFollowArticlePageList(Page<ArticleVo> page, Integer userId);

    List<ArticleVo> getRecommendArticles();

    Boolean updateArticlesState(List<Article> articles, Integer state);

    Page<ArticleVo> getArticlePageListWithRecommend(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, String searchWord, Boolean recommend);
}
