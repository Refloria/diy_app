package com.hyc.myweb.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@Configuration
public class MyWebConfigurer extends WebMvcConfigurationSupport {
    @Value("${upload.api}")
    private String api;
    @Value("${upload.path}")
    private String path;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(api + "**")
                .addResourceLocations("file:" + path);
        super.addResourceHandlers(registry);
    }
}
