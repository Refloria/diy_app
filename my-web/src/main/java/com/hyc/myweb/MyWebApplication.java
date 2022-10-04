package com.hyc.myweb;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(value = {"com.hyc.myweb.mapper"})
public class MyWebApplication {

    public static void main(String[] args) {
        SpringApplication.run(MyWebApplication.class, args);
    }

}
