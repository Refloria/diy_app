package com.hyc.myweb.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Article;
import com.hyc.myweb.bean.vo.ArticleDetail;
import com.hyc.myweb.bean.vo.ArticleVo;
import com.hyc.myweb.bean.wrapper.ArticleStateChangeRequest;
import com.hyc.myweb.bean.wrapper.PageListRequest;
import com.hyc.myweb.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import result.Result;

import java.util.List;
import java.util.Map;


@RestController
public class ArticleController {

    @Autowired
    ArticleService articleService;

    @Autowired
    UserService userService;

    @Autowired
    FavoriteService favoriteService;

    @Autowired
    FollowService followService;

    @Autowired
    CommentService commentService;

    /**
     * 获取文章列表
     *
     * @param request
     * @return
     */
    @PostMapping("/getArticlePageList")
    @PreAuthorize("hasAnyAuthority('user','admin')")
    @ResponseBody
    public Result<Page<ArticleVo>> getArticlePageList(@RequestBody PageListRequest<ArticleVo> request) {
        Page<ArticleVo> p = articleService.getArticlePageList(request.getPage(), request.getSortingColumn(),
                request.getIsDesc(), request.getArticleState(), request.getUserId(), request.getSearchWord());
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }

    /**
     * 获取关注作者文章列表
     *
     * @param request
     * @return
     */
    @PostMapping("/getFollowArticlePageList")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Page<ArticleVo>> getFollowArticlePageList(@RequestBody PageListRequest<ArticleVo> request) {
        Page<ArticleVo> p = articleService.getFollowArticlePageList(request.getPage(), request.getUserId());
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }

    /**
     * 获取文章详情
     *
     * @param requestArticle
     * @return
     */
    @PostMapping("/getArticle")
    @PreAuthorize("hasAnyAuthority('user','admin')")
    @ResponseBody
    public Result<ArticleVo> getArticle(@RequestBody Article requestArticle) {
        ArticleVo article = articleService.getArticleById(requestArticle.getId());
        if (article != null) {
            return Result.success(article);
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/loadArticleDetail")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<ArticleDetail> loadArticleDetail(@RequestBody Article requestArticle) {
        Integer articleId = requestArticle.getId();
        if (articleId == null) return Result.failed("Article id is null.");

        ArticleVo article = articleService.getArticleById(articleId);
        if (article == null) return Result.failed("No such article. id: " + articleId.toString());

        ArticleDetail articleDetail = new ArticleDetail();
        articleDetail.copyFromArticleVo(article);
        articleDetail.setFavoriteAmount(favoriteService.countFavorite(articleId));

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Integer userId = userService.getByName(userDetails.getUsername()).getId();
        articleDetail.setIsFavorite(favoriteService.getByUserIdAndArticleId(userId, articleId) != null);
        articleDetail.setIsFollow(followService.getByUserIdAndFollowUserId(userId, articleDetail.getAuthorId()) != null);
        return Result.success(articleDetail);
    }

    /**
     * 删除文章
     *
     * @param requestArticle
     * @return
     */
    @PostMapping("/deleteArticle")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> deleteArticle(@RequestBody Article requestArticle) {
        if (articleService.removeById(requestArticle.getId())) {
            return Result.success();
//            return new Result(200, "删除成功");
        } else {
            return Result.failed();
//            return new Result(400, "删除失败");
        }
    }

    /**
     * 发布或编辑文章
     *
     * @param article
     * @return
     */
    @PostMapping("/saveOrUpdateArticle")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> saveOrUpdateArticle(@RequestBody Article article) {
        if (articleService.saveOrUpdateArticle(article)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200, "上传成功");
//        } else {
//            return new Result(400, "上传失败");
//        }
    }

    /**
     * 上架文章
     *
     * @param request
     * @return
     */
    @PostMapping("/putArticleOnShelf")
    @PreAuthorize("hasAuthority('admin')")
    @ResponseBody
    public Result<Map<String, String>> putArticleOnShelf(@RequestBody ArticleStateChangeRequest request) {
        List<Article> articles = request.getArticles();
//        for (Article article : articles) {
//            article.setState(1);
//        }
        if (articleService.updateArticlesState(articles, articleService.ON_SHELF_STATE)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200, "");
//        } else {
//            return new Result(400, "");
//        }
    }

    /**
     * 下架文章
     *
     * @param request
     * @return
     */
    @PostMapping("/takeArticleOffShelf")
    @PreAuthorize("hasAnyAuthority('user','admin')")
    @ResponseBody
    public Result<Map<String, String>> takeArticleOffShelf(@RequestBody ArticleStateChangeRequest request) {
        List<Article> articles = request.getArticles();
//        for (Article article : articles) {
//            article.setState(2);
//        }
        if (articleService.updateArticlesState(articles, articleService.OFF_SHELF_STATE)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200, "");
//        } else {
//            return new Result(400, "");
//        }
    }

    /**
     * 提交文章审核
     *
     * @param request
     * @return
     */
    @PostMapping("/submitArticleForChecking")
    @PreAuthorize("hasAnyAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> submitArticleForChecking(@RequestBody ArticleStateChangeRequest request) {
        List<Article> articles = request.getArticles();
//        for (Article article : articles) {
//            article.setState(0);
//        }
        if (articleService.updateArticlesState(articles, articleService.WAIT_CHECKING_STATE)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200, "");
//        } else {
//            return new Result(400, "");
//        }
    }

//    @PostMapping("/setArticleState")
//    @ResponseBody
//    public Result setArticleState(@RequestBody ArticleStateChangeRequest request) {
//        List<Article> articles = request.getArticles();
//        for (Article article : articles) {
//            article.setState(request.getState());
//        }
//        if (articleService.updateBatchById(articles)) {
//            return new Result(200, "");
//        } else {
//            return new Result(400, "");
//        }
//    }


    @PostMapping("/getRecommendArticles")
    @PreAuthorize("hasAnyAuthority('user')")
    @ResponseBody
    public Result<List<ArticleVo>> getRecommendArticles() {
        List<ArticleVo> articles = articleService.getRecommendArticles();
        if (articles != null) {
            return Result.success(articles);
        } else {
            return Result.failed();
        }
    }
}
