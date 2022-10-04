package com.hyc.myweb.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Follow;
import com.hyc.myweb.bean.vo.UserVo;
import com.hyc.myweb.bean.wrapper.PageListRequest;
import com.hyc.myweb.service.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import result.Result;

import java.util.Map;

@RestController
public class FollowController {

    @Autowired
    FollowService followService;

    @PostMapping("/isFollow")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Boolean> isFollow(@RequestBody Follow request) {
        Follow follow = followService.getByUserIdAndFollowUserId(request.getUserId(), request.getFollowUserId());
        if (follow != null) {
            return Result.success(true);
        } else {
            return Result.success(false);
        }
//            return new Result(200, "", true);
//        } else {
//            return new Result(200, "", false);
//        }
    }

    @PostMapping("/getFollowPageList")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Page<UserVo>> getFollowPageList(@RequestBody PageListRequest<UserVo> request) {
        Page<UserVo> page;
        page = followService.getFollowPageList(request.getPage(), request.getUserId());
        if (page != null) {
            return Result.success(page);
        } else {
            return Result.failed();
        }
//            return new Result(200, "关注列表获取成功", p);
//        } else {
//            return new Result(400, "关注列表获取失败");
//        }
    }

    @PostMapping("/getFansPageList")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Page<UserVo>> getFansPageList(@RequestBody PageListRequest<UserVo> request) {
        Page<UserVo> page;
        page = followService.getFansPageList(request.getPage(), request.getUserId());
        if (page != null) {
            return Result.success(page);
        } else {
            return Result.failed();
        }
//            return new Result(200, "粉丝列表获取成功", page);
//        } else {
//            return new Result(400, "粉丝列表获取失败");
//        }
    }

    @PostMapping("/countFollow")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Integer> countFollow(@RequestBody Follow request) {
//        return new Result(200, "", followService.countFollow(request.getUserId()));
        return Result.success(followService.countFollow(request.getUserId()));
    }

    @PostMapping("/countFans")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Integer> countFans(@RequestBody Follow request) {
//        return new Result(200, "", followService.countFans(request.getFollowUserId()));
        return Result.success(followService.countFans(request.getFollowUserId()));
    }

    @PostMapping("/follow")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> follow(@RequestBody Follow follow) {
//        UserToken userToken = userTokenService.getByUserToken(token);
//        if (userToken == null) {
//            return new Result(399, "未登录，验证token失败");
//        }
//        follow.setUserId(userToken.getUserId());
        if (followService.saveIfNotExist(follow)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200);
//        } else {
//            return new Result(400);
//        }
    }

    @PostMapping("/cancelFollow")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> cancelFollow(@RequestBody Follow follow) {
//        UserToken userToken = userTokenService.getByUserToken(token);
//        if (userToken == null) {
//            return new Result(399, "未登录，验证token失败");
//        }
//        follow.setUserId(userToken.getUserId());
        if (followService.removeByUserIdAndFollowUserId(follow.getUserId(), follow.getFollowUserId())) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200);
//        } else {
//            return new Result(400);
//        }
    }
}
