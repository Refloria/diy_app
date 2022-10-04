package com.hyc.myweb.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hyc.myweb.bean.po.User;
import com.hyc.myweb.bean.vo.UserVo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper extends BaseMapper<User> {

    @Select("select * from user where username = #{username}")
    User selectByName(@Param("username") String username);

    @Select("select * from user where username = #{username} and password = #{password}")
    User selectByNameAndPassword(@Param("username") String username, @Param("password") String password);

    @Select({"select a.name",
            "from role_authority as ra inner join authority as a on ra.authority_id = a.id ",
            "where role_id = (select role_id from user where username = #{username})"})
    List<String> queryUserOwnedAuthority(@Param("username") String username);

    @Select({"select id, nickname, picture, username from user as u",
            "inner join (select ra.role_id from role_authority as ra inner join (select * from authority where name = 'user') as a on ra.authority_id = a.id) as r on r.role_id = u.role_id",
            "where username like concat('%',#{searchWord},'%')",
            "or nickname like concat('%',#{searchWord},'%')"})
    @Results(id = "userBrief", value = {
            @Result(column = "id", property = "id"),
            @Result(column = "nickname", property = "nickname"),
            @Result(column = "picture", property = "picture"),
    })
    List<UserVo> getUserPageListWithinSearchWord(Page<UserVo> page, String searchWord);

}
