package com.hyc.myweb.controller;

import com.hyc.myweb.bean.wrapper.ImageResponse;
import com.hyc.myweb.utils.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import result.Result;

import java.io.File;
import java.io.IOException;
import java.util.*;


@RestController
public class UploadController {
    @Value("${server.port}")
    private String port;
    @Value("${upload.api}")
    private String api;
    @Value("${upload.path}")
    private String path;

    @PostMapping("/upload")
    @PreAuthorize("hasAuthority('user')")
    public Result<List<String>> uploadImg(MultipartFile file) throws Exception {
//        Result result = new Result(400);
        String folder = path;
        File imageFolder = new File(folder);
        File f = new File(imageFolder, StringUtils.getRandomName(4) +
                Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().length() - 4));
        if (f.getParentFile().exists() || f.getParentFile().mkdirs()) {
            try {
                file.transferTo(f);

                RestTemplate restTemplate = new RestTemplate();
                Map<String, List<String>> param = new HashMap<>();
                List<String> files = new ArrayList<>();
                files.add(path+f.getName());
                param.put("list", files);
                ImageResponse response = restTemplate.postForObject("http://127.0.0.1:36678/upload", param, ImageResponse.class);
                if (response != null && response.isSuccess()) {
//                    result.setCode(200);
//                    result.setMsg("上传成功");
//                    result.setData(response.getResult());
                    return Result.success(response.getResult());
                }


//                String imgURL = "http://localhost:" + port + api + f.getName();
//                result.setUrl(imgURL);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return Result.failed();
    }
}
