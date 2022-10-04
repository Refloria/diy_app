package com.hyc.myweb.bean.wrapper;

import com.hyc.myweb.bean.po.Article;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class ArticleStateChangeRequest implements Serializable {
    List<Article> articles;
    Integer state;
}
