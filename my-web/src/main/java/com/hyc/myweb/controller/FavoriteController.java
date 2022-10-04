package com.hyc.myweb.controller;

import com.hyc.myweb.bean.po.Favorite;
import com.hyc.myweb.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import result.Result;

import java.util.Map;

@RestController
public class FavoriteController {

    @Autowired
    FavoriteService favoriteService;

    @PostMapping("/isFavorite")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Boolean> isLike(@RequestBody Favorite request) {
        Favorite favorite = favoriteService.getByUserIdAndArticleId(request.getUserId(), request.getArticleId());
        if (favorite != null) {
            return Result.success(true);
        } else {
            return Result.success(false);
        }
//            return new Result(200, "", true);
//        } else {
//            return new Result(200, "", false);
//        }
    }

    @PostMapping("/countFavorite")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Integer> countFavorite(@RequestBody Favorite request) {
//        return new Result(200, "", favoriteService.countLike(request.getArticleId()));
        return Result.success(favoriteService.countFavorite(request.getArticleId()));
    }

    @PostMapping("/favorite")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> like(@RequestBody Favorite favorite) {
//        UserToken userToken = userTokenService.getByUserToken(token);
//        if (userToken == null) {
//            return new Result(399, "未登录，验证token失败");
//        }
//        favorite.setUserId(userToken.getUserId());
        if (favoriteService.saveIfNotExist(favorite)) {
            return Result.success();
        } else {
            return Result.failed();
        }
//            return new Result(200);
//        } else {
//            return new Result(400);
//        }
    }

    @PostMapping("/cancelFavorite")
    @PreAuthorize("hasAuthority('user')")
    @ResponseBody
    public Result<Map<String, String>> cancelLike(@RequestBody Favorite favorite) {
//        UserToken userToken = userTokenService.getByUserToken(token);
//        if (userToken == null) {
//            return new Result(399, "未登录，验证token失败");
//        }
//        favorite.setUserId(userToken.getUserId());
        if (favoriteService.removeByUserIdAndArticleId(favorite.getUserId(), favorite.getArticleId())) {
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
