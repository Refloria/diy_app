package com.hyc.myweb.service;

import com.hyc.myweb.bean.po.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    UserService userService;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        User user = userService.getByName(userName);
        if (user == null) {
            //throw exception inform front end not this user
            throw new UsernameNotFoundException("user + " + userName + "not found.");
        }
//        List<String> roleCodeList = userRepository.queryUserOwnedRoleCodes(userName);
        List<String> roleCodeList = userService.queryUserOwnedAuthority(userName);
        List<GrantedAuthority> authorities = roleCodeList.stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());

        UserDetails userDetails = new org.springframework.security.core.userdetails.User(
                user.getUsername(), user.getPassword(), authorities);

        return userDetails;
    }

}
