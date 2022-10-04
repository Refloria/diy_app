package com.hyc.myweb.bean.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ArticleDetail implements Serializable {
    private Integer id;
    private String title;
    private String content;
    private Integer authorId;
    private String authorNickname;
    private String authorPicture;
    private Integer favoriteAmount;
    private Integer commentAmount;
    private Boolean isFollow;
    private Boolean isFavorite;

    public void copyFromArticleVo(ArticleVo article) {
        if (article.getId() != null) this.id = article.getId();
        if (article.getTitle() != null) this.title = article.getTitle();
        if (article.getContent() != null) this.content = article.getContent();
        if (article.getUserId() != null) this.authorId = article.getUserId();
        if (article.getUserNickname() != null) this.authorNickname = article.getUserNickname();
        if (article.getUserPicture() != null) this.authorPicture = article.getUserPicture();
    }
}
