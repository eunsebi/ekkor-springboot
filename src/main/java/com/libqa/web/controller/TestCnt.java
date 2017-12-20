package com.libqa.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by bakas.
 *
 * @author eunsebi
 * @since 2017-04-25
 */
@Controller
public class TestCnt {

    @RequestMapping("test")
    public String test() {
        return "test/test";
    }
}
