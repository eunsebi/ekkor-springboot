package com.libqa.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.libqa.web.service.index.IndexCrawler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {
    @Autowired
    private IndexCrawler indexCrawler;

    @RequestMapping({"/admin"})
    public ModelAndView index(ModelAndView mav) {
        //mav.addObject("displayIndex", indexCrawler.crawl());
        mav.setViewName("/admin/main");
        return mav;
    }

}
