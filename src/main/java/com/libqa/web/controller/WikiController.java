package com.libqa.web.controller;

import com.google.common.base.MoreObjects;
import com.libqa.application.enums.ListType;
import com.libqa.application.enums.Role;
import com.libqa.application.enums.WikiLikesType;
import com.libqa.application.enums.WikiRevisionActionType;
import com.libqa.application.framework.ResponseData;
import com.libqa.application.util.LibqaConstant;
import com.libqa.application.util.LoggedUserManager;
import com.libqa.application.util.StringUtil;
import com.libqa.web.domain.*;
import com.libqa.web.service.common.ActivityService;
import com.libqa.web.service.common.KeywordListService;
import com.libqa.web.service.common.KeywordService;
import com.libqa.web.service.space.SpaceService;
import com.libqa.web.service.wiki.WikiReplyService;
import com.libqa.web.service.wiki.WikiService;
import com.libqa.web.view.wiki.DisplayAjaxWiki;
import com.libqa.web.view.wiki.DisplayWiki;
import com.libqa.web.view.wiki.DisplayWikiLike;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.util.*;

import static com.libqa.application.framework.ResponseData.createFailResult;
import static com.libqa.application.framework.ResponseData.createSuccessResult;

/**
 * Created by songanji on 2015. 3. 1..
 */
@RestController
@Slf4j
public class WikiController {

    @Autowired
    WikiService wikiService;

    @Autowired
    WikiReplyService wikiReplyService;

    @Autowired
    private SpaceService spaceService;

    @Autowired
    KeywordListService keywordListService;

    @Autowired
    KeywordService keywordService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private LoggedUserManager loggedUserManager;

    @RequestMapping("/wiki/main")
    public ModelAndView main(Model model){
        ModelAndView mav = new ModelAndView("wiki/main");

        List<DisplayWiki> allWiki = wikiService.findByAllWiki(0, 10, LibqaConstant.SORT_TYPE_DATE);
        mav.addObject("allWiki", allWiki);

        User user = loggedUserManager.getUser();
        if(isUser(user)){
            Integer userId = user.getUserId();
            List<DisplayWiki> resecntWiki = wikiService.findByRecentWiki(userId, 0, 5);
            mav.addObject("resecntWiki", resecntWiki);
        }

        List<DisplayWiki> bestWiki = wikiService.findByBestWiki(0, 5);

        mav.addObject("bestWikiList", bestWiki);

        return mav;
    }

    private boolean isUser(User user) {
        return (user != null && user.getUserId() != null );
    }


    //@PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping("/wiki/write")
    public ModelAndView write(@ModelAttribute Space modelSpace){
        ModelAndView mav = wikiWrite(modelSpace, null);
        return mav;
    }

    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping("/wiki/write/{wikiId}" )
    public ModelAndView writeSub(@ModelAttribute Space modelSpace, @PathVariable("wikiId") Integer wikiId){
        ModelAndView mav = wikiWrite(modelSpace,wikiId);
        return mav;
    }

    private ModelAndView wikiWrite(Space modelSpace, Integer wikiId){
        ModelAndView mav = new ModelAndView("wiki/write");
        log.info("# spaceId : {}", modelSpace.getSpaceId());

        User user = loggedUserManager.getUser();

        log.info(" user = {}", user);

        if (user == null) {
            return sendAccessDenied("403","Hi, you do not have permission to access this page!");
        }

        if( modelSpace.getSpaceId() == null ){
            boolean isDeleted = false;    // 삭제 하지 않은 것
            List<Space> spaceList = spaceService.findAllByCondition(isDeleted);
            mav.addObject("spaceList", spaceList);
        }else{
            Space space = spaceService.findOne(modelSpace.getSpaceId());
            mav.addObject("space", space);
        }

        if( wikiId != null ){
            Wiki wiki = wikiService.findById(wikiId);
            mav.addObject("parentWiki",wiki);
        }

        return mav;
    }

    @RequestMapping(value = "/wiki/{wikiId}", method = RequestMethod.GET)
    public ModelAndView wikiDetail(@PathVariable Integer wikiId) {
        ModelAndView mav = new ModelAndView("wiki/view");

        Wiki wiki = wikiService.wikiDetail(wikiId);
        if( wiki == null ){
            return sendAccessDenied("404","The 404 or Not Found error message is an HTTP standard response code indicating that the client was able to communicate with a given server, but the server could not find what was requested");
        }
        //List<WikiReply> wikiReply = wiki.getWikiReplies();
        log.debug("# view : {}", wiki);
        //Wiki parentWiki = wikiService.findByParentId(wiki.getParentsId());
        //List<Wiki> subWikiList = wikiService.findBySubWikiId(wiki.getWikiId());

        //List<Activity> activityList = activityService.findByWikiId(wikiId);

        mav.addObject("wiki", wiki);
        //mav.addObject("subWikiList", subWikiList);
        //mav.addObject("parentWiki", parentWiki);
        //mav.addObject("activityList", activityList);

        return mav;
    }

    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping("/wiki/update/{wikiId}")
    public ModelAndView update(@PathVariable Integer wikiId){
        ModelAndView mav = new ModelAndView("wiki/write");
        log.debug("# wikiId : {}", wikiId);

        User user = loggedUserManager.getUser();
        if (user == null) {
            return sendAccessDenied("403","Hi, you do not have permission to access this page!");
        }

        Wiki wiki = wikiService.findById(wikiId);
        mav.addObject("wiki", wiki);

        Space space = spaceService.findOne(wiki.getSpaceId());
        mav.addObject("space", space);

        List<Keyword> keywordList = keywordService.findByWikiId(wikiId, false);
        mav.addObject("keywordList", keywordList);

        return mav;
    }

    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping(value = "/wiki/delete/{wikiId}", method = RequestMethod.GET)
    public ResponseData wikiDelete(@PathVariable Integer wikiId) {
        log.debug("# wikiId : {}", wikiId);

        Wiki wiki = wikiService.findById(wikiId);
        User user = loggedUserManager.getUser();
        int userId = user.getUserId();
        try {
            //위키만든 user, 공간주인, admin만 삭제 가능
            if( wiki.getInsertUserId() == userId
                    || wiki.getSpaceId() == userId
                    || user.getRole().equals(Role.ADMIN)
                    ){
                wiki.setDeleted(true);
                wikiService.save(wiki);
                RedirectView rv = new RedirectView("/wiki/main");
                rv.setExposeModelAttributes(false);
                new ModelAndView(rv);
            }else{
                return createFailResult("위키 생성자만 삭제할 수 있습니다.");
            }
        } catch (Exception e) {
            log.error("delete wiki error.", e);
            return createFailResult(wiki);
        }
        return createSuccessResult(wiki);
    }

    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping(value = "/wiki/lock/{wikiId}", method = RequestMethod.GET)
    public ResponseData wikiLock(@PathVariable Integer wikiId) {
        log.debug("# wikiId : {}", wikiId);

        User user = loggedUserManager.getUser();
        int userId = user.getUserId();
        Wiki wiki = wikiService.findById(wikiId);
        try {
            //위키만든 유저만 잠금가능
            if (wiki.getInsertUserId() == userId  || user.getRole().equals(Role.ADMIN)) {
                wiki.setLock(true);
                wikiService.save(wiki);
            } else {
                return createFailResult("위키 생성자만 잠금할 수 있습니다.");
            }
        } catch (Exception e){
            log.error("delete wiki error.", e);
            return createFailResult(wiki);
        }
        return createSuccessResult(wiki);
    }

    // @PreAuthorize("hasAuthority('USER')")
    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping(value = "/wiki/save", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<?> save(@ModelAttribute Wiki wiki, @ModelAttribute Keyword keyword){
        try{
            log.debug("####### WIKI SAVE Begin INFO ########");
            log.debug("wiki = {}", wiki);
            log.debug("wiki.wikiFile = {}", wiki.getWikiFiles());
            User user = loggedUserManager.getUser();
            Date now = new Date();

            wiki.setUserId(user.getUserId());
            wiki.setUserNick(user.getUserNick());
            wiki.setInsertDate(now);
            wiki.setInsertUserId(user.getUserId());
            wiki.setInsertUserNick(user.getUserNick());
            wiki.setUpdateDate(now);
            wiki.setUpdateUserId(user.getUserId());
            wiki.setUpdateUserNick(user.getUserNick());

            if( wiki.getParentsId() == null ){ // 부모위키 번호가 없으면 Root에 생성되는 것이므로 Depth는  0
                wiki.setDepthIdx(0);
                wiki.setOrderIdx(0);
            } else { // 부모 위키 번호가 있으면 Depth 가 늘어남
                Integer maxOrderIdx = wikiService.maxOrderIdx(wiki.getParentsId(), wiki.getDepthIdx() + 1);
                if( maxOrderIdx == 0 && wiki.getDepthIdx() > 0 ){
                    maxOrderIdx = wiki.getOrderIdx();
                }

                if( maxOrderIdx > 0 ){
                    List<Wiki> list = wikiService.findByGroupIdxAndOrderIdxGreaterThanAndIsDeleted( wiki.getGroupIdx(), maxOrderIdx+1 );
                    if( list != null && list.size() > 0 ){
                        for( Wiki tempWiki : list ){
                            tempWiki.setOrderIdx( tempWiki.getOrderIdx() + 1  );
                            wikiService.save(tempWiki);
                            log.debug("####### WIKI SAVE After INFO ########");
                        }
                    }
                }
                wiki.setOrderIdx( maxOrderIdx+1 );
                wiki.setDepthIdx( wiki.getDepthIdx() + 1 );
            }

            Wiki result = wikiService.saveWithKeyword(wiki, keyword);
            log.debug("result = {}", result);

            return ResponseData.createSuccessResult(result);

        }catch(Exception e){
            e.printStackTrace();
            log.error(e.toString());
            return ResponseData.createFailResult(wiki);
        }

    }


    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    @RequestMapping(value = "/wiki/update", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<?> update(@ModelAttribute Wiki paramWiki, @ModelAttribute Keyword paramKeyword){
        try{
            log.debug("####### WIKI SAVE Begin INFO ########");
            log.debug("wiki = {}", paramWiki);
            log.debug("wiki.wikiFile = {}", paramWiki.getWikiFiles());

            User user = loggedUserManager.getUser();
            Integer wikiId = paramWiki.getWikiId();

            Wiki currentWiki = wikiService.findById(wikiId);
            currentWiki.setWikiFiles( paramWiki.getWikiFiles() );

            currentWiki.setTitle(paramWiki.getTitle());
            currentWiki.setContents(paramWiki.getContents());
            currentWiki.setContentsMarkup(paramWiki.getContentsMarkup());

            currentWiki.setUpdateDate(new Date());
            currentWiki.setUpdateUserId(user.getUserId());
            currentWiki.setUpdateUserNick(user.getUserNick());

            Wiki result = wikiService.updateWithKeyword(currentWiki, paramKeyword, WikiRevisionActionType.UPDATE_WIKI);


            log.debug("####### WIKI SAVE After INFO ########");
            log.debug("result = {}", result);

            return ResponseData.createSuccessResult(result);
        }catch(Exception e){
            e.printStackTrace();
            log.error(e.toString());
            return ResponseData.createFailResult(paramWiki);
        }

    }

    @RequestMapping(value = "/wiki/count", method = RequestMethod.GET)
    @ResponseBody
    public String wikiCount() {
        List<Wiki> wikis = wikiService.findAllByCondition();
        return wikis.size() + "";
    }

    @RequestMapping(value = "/wiki/allList/{listViewType}", method = RequestMethod.GET)
    public ResponseData<DisplayAjaxWiki> wikiListViewType(@PathVariable("listViewType") String listViewType) {

        List<DisplayWiki> displayWikis = null;
        DisplayAjaxWiki displayAjaxWiki = new DisplayAjaxWiki();
        try{
            displayWikis = wikiService.findByAllWiki(0, 10, listViewType);
            displayAjaxWiki.setAllWiki(displayWikis);
        }catch (Exception e){
            log.error(e.toString());
            return ResponseData.createFailResult(displayAjaxWiki);
        }
        return ResponseData.createSuccessResult(displayAjaxWiki);
    }

    @RequestMapping(value = "/wiki/list/{listType}", method = RequestMethod.GET)
    public ModelAndView wikiList(@PathVariable String listType
            ,@RequestParam("page") Integer page ) {
        ModelAndView mav = new ModelAndView("wiki/list");

        listType = StringUtil.nullToString(listType);
        page = MoreObjects.firstNonNull(page, 0);
        List<DisplayWiki> wikiList = null;

        if( ListType.ALL.getName().equals(listType) ){

        }else if( ListType.BEST.getName().equals(listType)){
            // 베스트 위키 조회
            wikiList = wikiService.findByBestWiki(page, page+15);
            mav.addObject("listTitle","베스트위키 List");

        }else if( ListType.RESENT.getName().equals(listType) ){

            User user = loggedUserManager.getUser();
            if(isUser(user)){
                Integer userId = user.getUserId();
                wikiList = wikiService.findByRecentWiki(userId, page, page+15);
            }
            mav.addObject("listTitle","최근 활동 List");
        }

        mav.addObject("listWiki", wikiList);
        mav.addObject("page",page);
        mav.addObject("pages",(page/6)+1);

        return mav;
    }

    @RequestMapping(value = "/wiki/list/keyword/{keywordNm}", method = RequestMethod.GET)
    public ModelAndView keywordWikiList(@PathVariable String keywordNm) {
        ModelAndView mav = new ModelAndView("wiki/list");

        List<DisplayWiki> keyworldsWiki = wikiService.findWikiListByKeyword(keywordNm, 0, 15);

        mav.addObject("listWiki", keyworldsWiki);
        mav.addObject("selectKeywordName", keywordNm);
        mav.addObject("listTitle",keywordNm+" 위키 List");


        return mav;
    }

    @RequestMapping(value = "/wiki/search", method = RequestMethod.GET)
    public ModelAndView searchWikiList(@RequestParam String text) {
        ModelAndView mav = new ModelAndView("wiki/list");
        log.debug("# searchWikiList : {}", text);

        List<DisplayWiki> keyworldsWiki = wikiService.findWikiListByContentsMarkup(text, 0, 15);
        mav.addObject("listWiki", keyworldsWiki);
        mav.addObject("searchText", text);
        mav.addObject("listTitle",text+" 위키 List");

        return mav;
    }

    @RequestMapping(value = "/wiki/saveLike", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<DisplayWikiLike> saveLike(
            @RequestParam("type") WikiLikesType type, @RequestParam("num") int num) {
        log.debug("# type : {}", type);
        log.debug("# num : {}", num);

        DisplayWikiLike displayWikiLike = null;
        try{
            User user = loggedUserManager.getUser();
            if(isUser(user)){
                WikiLike wikiLike = new WikiLike();
                wikiLike.setUserId(user.getUserId());
                if( type == WikiLikesType.WIKI ){
                    wikiLike.setWikiId(num);
                }else if( type == WikiLikesType.COMMENT ){
                    wikiLike.setReplyId(num);
                }

                displayWikiLike = wikiService.updateLike(wikiLike);
            }
            return ResponseData.createSuccessResult(displayWikiLike);
        }catch(Exception e){
            log.error(e.toString());
            return ResponseData.createFailResult(displayWikiLike);
        }
    }

    @RequestMapping(value = "/wiki/reply/save", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<?> ReplySave(@ModelAttribute WikiReply wikiReply){
        try{
            log.debug("####### WIKI SAVE Begin INFO ########");
            log.debug("wiki = {}", wikiReply);
            User user = loggedUserManager.getUser();

            wikiReply.setUserNick(user.getUserNick());
            wikiReply.setUserId(user.getUserId());

            wikiReply.setInsertDate(new Date());
            WikiReply result = wikiReplyService.save(wikiReply);

            log.debug("####### WIKI SAVE After INFO ########");
            log.debug("result = {}", result);

            return ResponseData.createSuccessResult(result);
        }catch(Exception e){
            log.error(e.toString());
            return ResponseData.createFailResult(wikiReply);
        }

    }

    public ModelAndView sendAccessDenied(String code, String msg) {
        ModelAndView mav = new ModelAndView("/common/"+code);
        mav.addObject("msg", msg);

        return mav;
    }
}
