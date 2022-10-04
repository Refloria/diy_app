package com.hyc.myweb.bean.wrapper;

import lombok.Data;

import java.util.List;

@Data
public class PageWrapper<E> {
    private Integer current;  // 当前页码
    private Integer size;  // 每页显示大小
    private Long total;  // 数据总条数
    private List<E> dataList;
}
