package com.hyc.myweb.bean.wrapper;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class ImageResponse implements Serializable {
    private boolean success;
    private List<String> result;
}
