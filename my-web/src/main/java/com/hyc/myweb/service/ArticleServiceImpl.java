package com.hyc.myweb.service;

import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hyc.myweb.bean.vo.ArticleVo;
import com.hyc.myweb.mapper.ArticleMapper;
import com.hyc.myweb.bean.po.Article;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;


@Service("articleService")
@AllArgsConstructor
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService {
    @Autowired
    private final ArticleMapper articleMapper;

    private final Map<String, String> SortingColumns = new HashMap<String, String>() {
        {
            put("id", "id");
            put("userNickname", "nickname");
            put("publishTime", "publish_time");
            put("title", "title");
            put("keyWeight", "key_weight");
            put("favorites", "favorites");
            put("comments", "comments");
        }
    };

    @Override
    public Page<ArticleVo> getArticlePageList(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, Integer articleState, Integer userId) {

        if (articleState == null) articleState = 1;

        setOrder(page, sortingColumn, isDesc);

        if (sortingColumn != null && sortingColumn.equals("favorites")) {
            return page.setRecords(articleMapper.getArticlesWithFavorites(page));
        } else if (sortingColumn != null && sortingColumn.equals("comments")) {
            return page.setRecords(articleMapper.getArticlesWithComments(page));
        }
        if (userId != null) {
            return page.setRecords(articleMapper.getUserArticles(page, userId, articleState));
        } else {
            return page.setRecords(articleMapper.getArticles(page, articleState));
        }
    }

    @Override
    public Page<ArticleVo> getArticlePageList(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, Integer articleState, Integer userId, String searchWord) {

        if (articleState == null) articleState = 1;

        List<String> searchWords;
        if (searchWord == null) {
            return getArticlePageList(page, sortingColumn, isDesc, articleState, userId);
        } else {
            searchWords = parseSearchWords(searchWord);
        }

        setOrder(page, sortingColumn, isDesc);

        if (sortingColumn != null && sortingColumn.equals("favorites")) {
            return page.setRecords(articleMapper.getArticlesWithFavoritesWithinSearchWord(page, searchWords));
        } else if (sortingColumn != null && sortingColumn.equals("comments")) {
            return page.setRecords(articleMapper.getArticlesWithCommentsWithinSearchWord(page, searchWords));
        } else {
            return page.setRecords(articleMapper.getArticlesWithinSearchWord(page, articleState, searchWords));
        }

    }

    @Override
    public Page<ArticleVo> getArticlePageListWithRecommend(Page<ArticleVo> page, String sortingColumn, Boolean isDesc, String searchWord, Boolean recommend) {

        setOrder(page, sortingColumn, isDesc);

        if (searchWord != null) {
            List<String> searchWords = parseSearchWords(searchWord);
            return page.setRecords(articleMapper.getArticlesWithRecommendWithinSearchWord(page, recommend, searchWords));
        } else {
            return page.setRecords(articleMapper.getArticlesWithRecommend(page, recommend));
        }
    }

    private void setOrder(Page<ArticleVo> page, String sortingColumn, Boolean isDesc) {
        if (sortingColumn != null && SortingColumns.containsKey(sortingColumn)) {
            if (isDesc != null && !isDesc) {
                page.addOrder(OrderItem.asc(SortingColumns.get(sortingColumn)));
            } else {
                page.addOrder(OrderItem.desc(SortingColumns.get(sortingColumn)));
            }
        }
        page.addOrder(OrderItem.desc("publish_time"));
    }

    private List<String> parseSearchWords(String searchWord) {
        List<String> searchWords = new ArrayList<>();
        if (searchWord != null) {
            searchWord = searchWord.trim();
            String[] words = searchWord.split(" |\\.|,|，|。|、|\\+");
            for (String word : words) {
                if (!word.isEmpty()) {
                    searchWords.add(word);
                }
            }
        }
        return searchWords;
    }
//
//    public Page<ArticleVo> getUserArticlePageList(Page<ArticleVo> page, Integer userId, String sortingColumn, Boolean isDesc, Integer articleState) {
//        if (sortingColumn == null || !SortingColumns.containsKey(sortingColumn) || isDesc == null) {
//            page.addOrder(OrderItem.desc("publish_time"));
//        } else {
//            String columnName = SortingColumns.get(sortingColumn);
//            if (isDesc) {
//                page.addOrder(OrderItem.desc(columnName));
//            } else {
//                page.addOrder(OrderItem.asc(columnName));
//            }
//        }
//        if (articleState == null) articleState = 1;
//        return page.setRecords(articleMapper.getUserArticlePageList(page, userId, articleState));
//    }

    @Override
    public ArticleVo getArticleById(Integer id) {
        return articleMapper.selectArticleById(id);
    }

    @Override
    public Boolean saveOrUpdateArticle(Article article) {
        // 获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        article.setLastEditTime(time);

        if (article.getId() == null) {
            article.setPublishTime(time);
        } else {
            Article a = super.getById(article.getId());
            if (a.getState().equals(ON_SHELF_STATE)) {
                article.setState(WAIT_CHECKING_STATE);
                article.setRecommend(false);
            }
        }
        return super.saveOrUpdate(article);

    }

    @Override
    public Boolean updateArticlesState(List<Article> articles, Integer state) {
        for (Article article : articles) {
            article.setState(state);
            if (!state.equals(ON_SHELF_STATE)) {
                Article a = super.getById(article.getId());
                if (a.getRecommend()) {
                    article.setRecommend(false);
                }
            }
        }
        return super.updateBatchById(articles);
    }

    @Override
    public Integer countArticles(Integer authorId) {
        return articleMapper.countUserArticles(authorId);
    }

    @Override
    public Page<ArticleVo> getFollowArticlePageList(Page<ArticleVo> page, Integer userId) {
        return page.setRecords(articleMapper.getFollowArticles(page, userId));
    }

    @Override
    public List<ArticleVo> getRecommendArticles() {
        return articleMapper.getRecommendArticles();
    }
}
