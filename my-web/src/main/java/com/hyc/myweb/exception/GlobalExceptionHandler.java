package com.hyc.myweb.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import result.Result;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

//    /**
//     * 处理自定义的业务异常
//     *
//     * @param req
//     * @param e
//     * @return
//     */
//    @ExceptionHandler(value = BizException.class)
//    @ResponseBody
//    public ResultBody bizExceptionHandler(HttpServletRequest req, BizException e) {
//        logger.error("发生业务异常！原因是：{}", e.getErrorMsg());
//        return ResultBody.error(e.getErrorCode(), e.getErrorMsg());
//    }
//
//    /**
//     * 处理空指针的异常
//     *
//     * @param req
//     * @param e
//     * @return
//     */
//    @ExceptionHandler(value = NullPointerException.class)
//    @ResponseBody
//    public CommonResult<Map<String, Object>> exceptionHandler(HttpServletRequest req, NullPointerException e) {
//        logger.error("发生空指针异常！原因是:", e);
//        return CommonResult.failed("发生空指针异常！原因是:" + e.toString());
//    }


    @ExceptionHandler(value = ServletException.class)
    @ResponseBody
    public Result<Map<String, Object>> servletExceptionHandler(HttpServletRequest req, Exception e) {
        logger.error("servlet error！", e);
        return Result.failed(e.toString());
    }

    /**
     * 处理其他异常
     *
     * @param req
     * @param e
     * @return
     */
    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public Result<Map<String, Object>> exceptionHandler(HttpServletRequest req, Exception e) {
        logger.error("未知异常！", e);
        return Result.failed(e.toString());
    }
}
