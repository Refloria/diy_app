package com.hyc.myweb.bean.wrapper;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

import java.io.Serializable;
import java.util.Collection;

@Data
public class LoginResponse implements Serializable {
    String username;
    Integer userId;
    String token;
    String refreshToken;
    Collection<? extends GrantedAuthority> authorities;
}
