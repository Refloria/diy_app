package com.hyc.myweb.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.pagination.optimize.JsqlParserCountOptimize;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConditionalOnClass(value = PaginationInterceptor.class)
public class MyBatisPlusConfig {
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor interceptor = new PaginationInterceptor();
        // 设置请求的页面大于最大页面后操作，true调回到首页,false继续请求，默认false
        // interceptor.setOverflow(false);
        // 设置最大单页限制数量,默认500条,-1不受限制
        // interceptor.setLimit(500);
        interceptor.setCountSqlParser(new JsqlParserCountOptimize(true));
        return interceptor;
    }
}
