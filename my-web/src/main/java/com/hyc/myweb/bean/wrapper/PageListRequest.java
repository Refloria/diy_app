package com.hyc.myweb.bean.wrapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

import java.io.Serializable;

@Data
public class PageListRequest<T> implements Serializable {
    Page<T> page;
    Integer userId;
    Integer id;
    String sortingColumn;
    Boolean isDesc;
    Integer articleState;
    String searchWord;
}
