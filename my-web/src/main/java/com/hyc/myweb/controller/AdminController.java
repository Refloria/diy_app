package com.hyc.myweb.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Article;
import com.hyc.myweb.bean.po.User;
import com.hyc.myweb.bean.vo.ArticleVo;
import com.hyc.myweb.bean.wrapper.ArticleStateChangeRequest;
import com.hyc.myweb.bean.wrapper.LoginResponse;
import com.hyc.myweb.bean.wrapper.PageListRequest;
import com.hyc.myweb.service.ArticleService;
import com.hyc.myweb.service.UserService;
import com.hyc.myweb.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;
import result.Result;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    /**
     * 登录
     *
     * @param requestUser
     * @return
     */
    @PostMapping(value = "/login")
    @ResponseBody
    public Result<LoginResponse> login(@RequestBody User requestUser) {
        String username = requestUser.getUsername();
        username = HtmlUtils.htmlEscape(username);
        User user = userService.getByName(username);
        if (user == null) {
            return Result.failed("用户名不存在");
        }

        if (new BCryptPasswordEncoder().matches(requestUser.getPassword(), user.getPassword())) {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            boolean loginSuccess = false;
            for (GrantedAuthority authority : userDetails.getAuthorities()) {
                if (authority.getAuthority().equals("admin")) {
                    loginSuccess = true;
                }
            }
            if (!loginSuccess)
                return Result.forbidden(null);

            LoginResponse response = new LoginResponse();
            response.setToken("Bearer " + jwtTokenUtil.generateToken(userDetails));
            response.setUsername(username);
            response.setUserId(user.getId());
            response.setAuthorities(userDetails.getAuthorities());
            return Result.success(response);
        } else {
            return Result.failed("密码错误");
        }
    }

    /**
     * 获取文章列表
     *
     * @param request
     * @return
     */
    @PostMapping("/getArticlePageList")
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
     * 获取文章详情
     *
     * @param requestArticle
     * @return
     */
    @PostMapping("/getArticle")
    @ResponseBody
    public Result<ArticleVo> getArticle(@RequestBody Article requestArticle) {
        ArticleVo article = articleService.getArticleById(requestArticle.getId());
        if (article != null) {
            return Result.success(article);
        } else {
            return Result.failed();
        }
    }

    /**
     * 上架文章
     *
     * @param request
     * @return
     */
    @PostMapping("/putArticleOnShelf")
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
    }

    /**
     * 下架文章
     *
     * @param request
     * @return
     */
    @PostMapping("/takeArticleOffShelf")
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
    }

    @PostMapping("/getRecommendArticles")
    @ResponseBody
    public Result<List<ArticleVo>> getRecommendArticles() {
        List<ArticleVo> articles = articleService.getRecommendArticles();
        if (articles != null) {
            return Result.success(articles);
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/recommendArticle")
    @ResponseBody
    public Result<Object> recommendArticle(@RequestBody Article article) {
        article.setRecommend(true);
        if (articleService.updateById(article)) {
            return Result.success();
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/cancelRecommendArticle")
    @ResponseBody
    public Result<Object> cancelRecommendArticle(@RequestBody ArticleStateChangeRequest request) {
        List<Article> articles = request.getArticles();
        for (Article article : articles) {
            article.setRecommend(false);
        }
        if (articleService.updateBatchById(articles)) {
            return Result.success();
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/getAddRecommendPageList")
    @ResponseBody
    public Result<Page<ArticleVo>> getRecommendArticlePageList(@RequestBody PageListRequest<ArticleVo> request) {
        Page<ArticleVo> p = articleService.getArticlePageListWithRecommend(request.getPage(), request.getSortingColumn(),
                request.getIsDesc(),  request.getSearchWord(),false);
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }

}
