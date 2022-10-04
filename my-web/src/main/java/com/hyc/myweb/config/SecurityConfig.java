package com.hyc.myweb.config;

import com.hyc.myweb.security.*;
import com.hyc.myweb.service.UserDetailsServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.header.Header;
import org.springframework.security.web.header.writers.StaticHeadersWriter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import javax.annotation.Resource;
import java.util.Arrays;


/**
 * SpringSecurity的配置
 *
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {


    @Resource
    private RestfulAccessDeniedHandler restfulAccessDeniedHandler;
    @Resource
    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {

        httpSecurity.headers().cacheControl(); // 禁用缓存
        httpSecurity
                .authorizeRequests()
//                .antMatchers("/**").permitAll()
                .antMatchers("/image/**").permitAll() //静态资源访问无需认证
                .antMatchers("/login","/register","/admin/login").permitAll() // 对登录注册要允许匿名访问
                .antMatchers("/admin/**").hasAuthority("admin") //admin开头的请求，需要admin权限
                .antMatchers("/article/**").hasAuthority("user") //需登陆才能访问的url
                .anyRequest().authenticated()  //默认其它的请求都需要认证，这里一定要添加
                .and()
                .csrf().disable()  //CSRF禁用，因为不使用session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)  //不需要session
                .and()
                .formLogin().disable() //禁用form登录
                .cors()  //支持跨域
                .and()   //添加header设置，支持跨域和ajax请求
                .headers().addHeaderWriter(new StaticHeadersWriter(Arrays.asList(
                //支持所有源的访问
                new Header("Access-control-Allow-Origin", "*"),
                //使ajax请求能够取到header中的jwt token信息
                new Header("Access-Control-Expose-Headers", "Authorization"))))
                .and()
                // 添加JWT filter
                .addFilterBefore(jwtAuthenticationTokenFilter(), UsernamePasswordAuthenticationFilter.class)
                // 添加自定义未授权和未登录结果返回
                .exceptionHandling()
                .accessDeniedHandler(restfulAccessDeniedHandler)
                .authenticationEntryPoint(restAuthenticationEntryPoint)
                .and()
                //拦截OPTIONS请求，直接返回header
                .addFilterAfter(new OptionsRequestFilter(), CorsFilter.class);
                //添加登录filter
//                .apply(new JsonLoginConfigurer<>()).loginSuccessHandler(new JsonLoginSuccessHandler());
//                .and()
//                //添加token的filter
//                .apply(new JwtLoginConfigurer<>()).tokenValidSuccessHandler(jwtRefreshSuccessHandler()).permissiveRequestUrls("/logout")
//                .and()
//                //使用默认的logoutFilter
//                .logout()
////              .logoutUrl("/logout")   //默认就是"/logout"
//                .addLogoutHandler(tokenClearLogoutHandler())  //logout时清除token
//                .logoutSuccessHandler(new HttpStatusReturningLogoutSuccessHandler()); //logout成功后返回200
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(detailsService())
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsServiceImpl detailsService() {
        return new UserDetailsServiceImpl();
    }

    @Bean
    public JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter() {
        return new JwtAuthenticationTokenFilter();
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

//    @Bean
//    public static NoOpPasswordEncoder passwordEncoder() {
//        return (NoOpPasswordEncoder) NoOpPasswordEncoder.getInstance();
//    }

    @Bean
    protected CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "HEAD", "OPTION"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.addExposedHeader("Authorization");
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

}
