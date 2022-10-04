package com.hyc.myweb.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.Follow;
import com.hyc.myweb.bean.vo.UserVo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FollowMapper extends BaseMapper<Follow> {

    @Select("select * from follow where user_id = #{userId} and follow_user_id = #{followUserId}")
    Follow selectByUserIdAndFollowUserId(@Param("userId") Integer userId,
                                         @Param("followUserId") Integer followUserId);

    @Select({"select u.id, u.nickname, u.picture, f.user_id as my_id",
            "from (select * from follow where user_id = #{userId}) as f",
            "inner join user u on f.follow_user_id=u.id",
            "order by f.time desc"})
    @Results(id = "userBrief", value = {
            @Result(property = "id", column = "id"),
            @Result(property = "nickname", column = "nickname"),
            @Result(property = "picture", column = "picture"),
            @Result(property = "isFollow", one = @One(select = "checkFollow"), column = "{followUserId = id, userId = my_id}"),
    })
    List<UserVo> getFollowPageList(Page<UserVo> page, @Param("userId") Integer userId);

    @Select({"select u.id, u.nickname, u.picture, f.follow_user_id as my_id",
            "from (select * from follow where follow_user_id = #{userId}) as f",
            "inner join user u on f.user_id=u.id",
            "order by f.time desc"})
    @ResultMap("userBrief")
    List<UserVo> getFansPageList(Page<UserVo> page, @Param("userId") Integer userId);

    @Select("select count(id) from follow where user_id = #{userId}")
    Integer countFollow(@Param("userId") Integer userId);

    @Select("select count(id) from follow where follow_user_id = #{followUserId}")
    Integer countFans(@Param("followUserId") Integer followUserId);

    @Delete("delete from follow where user_id = #{userId} and follow_user_id = #{followUserId}")
    Boolean deleteByUserIdAndFollowUserId(@Param("userId") Integer userId, @Param("followUserId") Integer followUserId);

    @Select("select count(id) from follow where user_id = #{userId} and follow_user_id = #{followUserId}")
    Boolean checkFollow(@Param("userId") Integer userId, @Param("followUserId") Integer followUserId);
}

