package com.hyc.myweb.security;

import com.hyc.myweb.utils.JwtTokenUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.annotation.Resource;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * JWT登录授权过滤器
 *
 * @author macro
 * @date 2018/4/26
 */
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {
    private static final Logger LOGGER = LoggerFactory.getLogger(JwtAuthenticationTokenFilter.class);
    @Resource
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Value("${jwt.tokenHeader}")
    private String tokenHeader;
    @Value("${jwt.tokenHead}")
    private String tokenHead;

    /**
     * token 拦截器
     * 在用户名和密码校验前添加的过滤器，
     * 如果请求中有jwt的token且有效，
     * 会取出token中的用户名，
     * 然后调用SpringSecurity的API进行登录操作。
     *
     * @param request
     * @param response
     * @param chain
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {
//        从请求头中获取token ，传来的 token 结构 前置请求头 jwt数据 （中间有个空格）
        String authHeader = request.getHeader(this.tokenHeader);
//        匹配前置请求头是否和后台设置的一样
        if (authHeader != null && authHeader.startsWith(this.tokenHead)) {
            // The part after "Bearer "
//            切割字符串，去除前置请求头，获取jwt的数据
            String authToken = authHeader.substring(this.tokenHead.length());
//            从jwt数据中获取username
            String username = jwtTokenUtil.getUserNameFromToken(authToken);
//            打印日志
            LOGGER.info("checking username:{}", username);
//            判断用户名是否存在，
//            SecurityContextHolder.getContext().getAuthentication() 获取储存用户信息 必定为空，因为用户信息返回给了前端
            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
//                通过用户名进行登录
                UserDetails userDetails = this.userDetailsService.loadUserByUsername(username);
                //验证token是否还有效
                if (jwtTokenUtil.validateToken(authToken, userDetails)) {
                    //获取用户 ，security里面的用户
                    UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    //设置用户信息
                    authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    LOGGER.info("authenticated user:{}", username);
                    //将该用户存入security中
                    SecurityContextHolder.getContext().setAuthentication(authentication);

                    // 刷新token
                    tryRefreshAndParseToken(authToken,response);
                }
            }
        }

        chain.doFilter(request, response);
    }

    /**
     * 试图刷新并返回token
     * @param token
     * @param response
     */
    public void tryRefreshAndParseToken(String token, HttpServletResponse response) {
        String refreshToken = "";
        try {
            refreshToken = jwtTokenUtil.refreshToken(token);
        } catch (Exception e) {
            logger.error("token刷新异常... token=" + token);
        }
        // 刷新成功，写入响应头
        if (refreshToken.length() > 0)
            response.addHeader("refresh-token", tokenHead + " " + refreshToken);
    }
}
