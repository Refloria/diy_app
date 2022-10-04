package com.hyc.myweb.controller;

import com.hyc.myweb.bean.wrapper.LoginResponse;
import com.hyc.myweb.bean.po.User;
import com.hyc.myweb.mapper.ArticleMapper;
import com.hyc.myweb.utils.JwtTokenUtil;
import com.hyc.myweb.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;
import result.Result;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@RestController
public class LoginController {

    @Autowired
    UserService userService;

    @Autowired
    UserDetailsService userDetailsService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private ArticleMapper articleMapper;

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
                if (authority.getAuthority().equals("user")) {
                    loginSuccess = true;
                }
            }
            if (!loginSuccess) return Result.forbidden(null);

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
     * 注册
     *
     * @param user
     * @return
     */
    @PostMapping(value = "/register")
    @ResponseBody
    public Result<Map<String, String>> register(@RequestBody User user) {
        if (user.getUsername() == null || user.getPassword() == null) {
            return Result.failed("用户名或密码不能为空！");
        }
        if (user.getNickname() == null) {
            user.setNickname(user.getUsername());
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        user.setRegisterTime(time);

        user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        try {
            if (userService.save(user)) {
                return Result.success();
            } else {
                return Result.failed();
            }
        } catch (Exception e) {
            return Result.failed();
        }
    }

//    /**
//     * 更新token
//     *
//     * @return
//     */
//    @PostMapping(value = "/refreshToken")
//    @PreAuthorize("hasAnyAuthority('user','admin')")
//    @ResponseBody
//    public CommonResult<UserVo> refreshToken() {
//        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        UserVo userVo = new UserVo();
//        userVo.setToken("Bearer " + jwtTokenUtil.generateToken(userDetails));
//        userVo.setRefreshToken("Bearer " + jwtTokenUtil.generateRefreshToken(userDetails));
//        return CommonResult.success(userVo);
//    }

//    @PostMapping(value = "/logout")
//    @ResponseBody
//    public Result logout(UserToken userToken) {
//        String token = userToken.getUserToken();
//        if (userTokenService.removeByUserToken(token)
//                || userTokenService.getByUserToken(token) == null) {
//            return new Result(200, "登出成功");
//        } else {
//            return new Result(400, "登出失败");
//        }
//    }
//
//    @PostMapping(value = "/checkLogin")
//    @ResponseBody
//    public Result checkLogin(UserToken userToken) {
//        UserToken token = userTokenService.getByUserToken(userToken.getUserToken());
//        if (token == null) {
//            return new Result(400);
//        } else {
//            return new Result(200, token);
//        }
//    }
}
