package com.libqa.web.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

/**
 * Created by bakas.
 *
 * @author eunsebi
 * @since 2017-11-21
 */

@RestController
public class PayController {

    @RequestMapping(value = "/pay", method = GET)
    public ModelAndView main(ModelAndView mav) {

        mav.setViewName("pay/main");
        return mav;
    }

}
