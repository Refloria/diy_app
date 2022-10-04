package com.hyc.myweb.utils;

import java.util.Random;

public class StringUtils {
    public static String getRandomString(int length) {
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }

    public static String getRandomName(int length) {
        StringBuilder name = new StringBuilder();
        for (int i = 0; i < length; i++) {
            if (i != 0) name.append("-");
            name.append(getRandomString(6));
        }
        return name.toString();
    }
}
