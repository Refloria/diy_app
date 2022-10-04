package com.hyc.myweb.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Follow;
import com.hyc.myweb.bean.po.User;
import com.hyc.myweb.bean.vo.UserVo;
import com.hyc.myweb.bean.wrapper.PageListRequest;
import com.hyc.myweb.service.ArticleService;
import com.hyc.myweb.service.FollowService;
import com.hyc.myweb.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import result.Result;

import java.util.Map;

@RestController
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    FollowService followService;

    @Autowired
    ArticleService articleService;

    @PostMapping("/getPersonPageDetail")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<UserVo> getPersonPageDetail(@RequestBody User request) {
        User user = userService.getById(request.getId());
        if (user == null)
            return Result.failed();
        UserVo userVo = new UserVo();
        userVo.copyFromUser(user);
        userVo.setFollows(followService.countFollow(request.getId()));
        userVo.setFans(followService.countFans(request.getId()));
        userVo.setArticles(articleService.countArticles(request.getId()));
        return Result.success(userVo);
    }

    @PostMapping("/getUserDetail")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<UserVo> getUserDetail(@RequestBody User request) {
        User user = userService.getById(request.getId());
        if (user == null)
            return Result.failed();
        UserVo userVo = new UserVo();
        userVo.copyFromUser(user);
        return Result.success(userVo);
    }

    @PostMapping("/getUserDetailWithFollow")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<UserVo> getUserDetailWithFollow(@RequestBody User request) {
        User user = userService.getById(request.getId());
        if (user == null)
            return Result.failed();
        UserVo userVo = new UserVo();
        userVo.copyFromUser(user);

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Integer userId = userService.getByName(userDetails.getUsername()).getId();
        Follow follow = followService.getByUserIdAndFollowUserId(userId,user.getId());
        userVo.setIsFollow(follow != null);
        return Result.success(userVo);
    }

    @PostMapping("/upgradeUserDetail")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> upgradeUserDetail(@RequestBody User user) {
        if (userService.updateById(user)) {
            return Result.success();
        } else {
            return Result.failed();
        }
    }

    @PostMapping("/getUserPageList")
    @ResponseBody
    public Result<Page<UserVo>> getUserPageList(@RequestBody PageListRequest<UserVo> request) {
        Page<UserVo> p = userService.getUserPageList(request.getPage(), request.getSearchWord());
        if (p != null) {
            return Result.success(p);
        } else {
            return Result.failed();
        }
    }
}
