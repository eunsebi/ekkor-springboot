package com.libqa.web.service.photo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.libqa.web.repository.PhotoRepository;
import com.libqa.web.view.photo.PhotoMain;
import com.libqa.web.view.photo.PhotoMainList;
import com.libqa.web.view.photo.PhotoWiki;
import com.libqa.web.view.photo.PhotoWikiList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Iterables;
import com.libqa.application.enums.ActivityType;
import com.libqa.application.enums.FavoriteType;
import com.libqa.application.enums.KeywordType;
import com.libqa.application.util.PageUtil;
import com.libqa.web.domain.*;
import com.libqa.web.repository.SpaceRepository;
import com.libqa.web.service.common.ActivityService;
import com.libqa.web.service.common.KeywordService;
import com.libqa.web.service.user.UserFavoriteService;
import com.libqa.web.service.user.UserService;
import com.libqa.web.service.wiki.WikiService;
import com.libqa.web.view.space.SpaceMain;
import com.libqa.web.view.space.SpaceMainList;
import com.libqa.web.view.space.SpaceWiki;
import com.libqa.web.view.space.SpaceWikiList;

import lombok.extern.slf4j.Slf4j;

/**
 * Created by yion on 2015. 3. 1..
 */
@Slf4j
@Service
public class PhotoServiceImpl implements PhotoService {

    @Autowired
    private PhotoRepository spaceRepository;

    @Autowired
    private KeywordService keywordService;

    @Autowired
    private UserFavoriteService userFavoriteService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private WikiService wikiService;

    @Autowired
    private UserService userService;


    @Override
    public Photo save(Photo space) {
        return spaceRepository.save(space);
    }

    @Override
    public List<Photo> findAllByCondition(boolean isDeleted) {
        return this.findAllByCondition(isDeleted, null, null);
    }


    @Override
    public List<Photo> findAllByCondition(boolean isDeleted, Integer startNum, Integer pageSize) {
        if (startNum == null) {
            return spaceRepository.findAllByIsDeleted(PageUtil.sortId("DESC", "spaceId"), isDeleted);
        } else {
            Page<Photo> pages = spaceRepository.findPagingByIsDeleted(
                    PageUtil.sortPageable(
                            startNum
                            , pageSize
                            , PageUtil.sortId("DESC", "spaceId"))
                    , isDeleted);

            return pages.getContent();
        }
    }


    @Override
    public PhotoMainList findPageBySort(boolean isDeleted, Integer startNum, Integer pageSize, String sortCondition) {
        Page<Photo> pages;

        pages = spaceRepository.findPagingByIsDeleted(
                PageUtil.sortPageable(
                        startNum
                        , pageSize
                        , PageUtil.sortId("DESC", sortCondition))
                , isDeleted);

        List<PhotoMain> spaceMains = convertSpaceMain(pages.getContent());
        PhotoMainList spaceMainList = new PhotoMainList(pages.getNumber(), pages.getTotalPages(), pages.getTotalElements(), spaceMains);
        return spaceMainList;
    }

    @Override
    public Photo findOne(Integer spaceId) {
        return spaceRepository.findOne(spaceId);
    }

    @Override
    public Photo saveWithKeyword(Photo space, Keyword keyword, ActivityType activityType) {
        Photo result = save(space);

        String[] keywordArrays = new String[0];
        String[] deleteKeywordArrays = new String[0];
        if (keyword.getKeywords() != null) {
            keywordArrays = keyword.getKeywords().split(",");
        }
        if (keyword.getDeleteKeywords() != null) {
            deleteKeywordArrays = keyword.getDeleteKeywords().split(",");
        }
        log.debug(" keywordArrays : {}", keywordArrays.length);
        if (keywordArrays.length > 0) {
            keywordService.saveKeywordAndList(keywordArrays, deleteKeywordArrays, KeywordType.SPACE, result.getSpaceId());
        }

        // Activity 생성
        this.saveActivities(result, activityType);

        return result;
    }

    private void saveActivities(Photo result, ActivityType activityType) {
        Activity activity = new Activity();
        activity.setSpaceId(result.getSpaceId());
        activity.setUserNick(result.getInsertUserNick());
        activity.setActivityType(activityType);
        activity.setUserId(result.getInsertUserId());
        activity.setActivityKeyword(KeywordType.SPACE);
        activity.setInsertDate(new Date());

        activityService.saveActivity(activity, result.getTitle());

    }

    @Override
    public List<Photo> findUserFavoriteSpace(Integer userId, boolean isDeleted) {

        List<UserFavorite> userFavoriteList;

        userFavoriteList = userFavoriteService.findByFavoriteTypeAndUserIdAndIsDeleted(FavoriteType.SPACE, userId, isDeleted);

        if (userFavoriteList.isEmpty()) {
            return null;
        }

        List<Photo> mySpaceList = new ArrayList<>();
        for (UserFavorite favorite : userFavoriteList) {
            Photo space = spaceRepository.findOne(favorite.getSpaceId());

            mySpaceList.add(space);
        }

        return mySpaceList;
    }

    @Override
    public Integer addSpaceFavorite(Integer spaceId, Integer userId, boolean isDeleted) {
        int result = 0;

        // 즐겨 찾기가 있는지 조회
        List<UserFavorite> userFavorites = userFavoriteService.findBySpaceIdAndUserId(spaceId, userId);

        UserFavorite userFavorite = Iterables.getFirst(userFavorites, null);
        try {
            if (userFavorite == null) {    // insert
                userFavorite = bindUserFavorite(spaceId, userId, isDeleted);
                userFavoriteService.save(userFavorite);
            } else {    // update
                updateFavorite(userFavorite, false);
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }

        return result;
    }


    @Override
    public Integer cancelSpaceFavorite(Integer spaceId, Integer userId, boolean isDeleted) {
        int result = 0;

        // 즐겨 찾기가 있는지 조회
        List<UserFavorite> userFavorites = userFavoriteService.findBySpaceIdAndUserIdAndIsDeleted(spaceId, userId, false);

        UserFavorite userFavorite = Iterables.getFirst(userFavorites, null);
        try {
            if (userFavorite != null) {    // 즐겨 찾기가 이미 있을 경우 수정
                updateFavorite(userFavorite, true);
                return 1;
            } // 없는 경우에는 즐겨찾기 삭제를 할 수 없음
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }

        return result;
    }

    @Override
    @Transactional
    public Photo delete(Photo space, User user) {
        space.setDeleted(true);
        space.setUpdateDate(new Date());
        space.setUpdateUserId(user.getUserId());
        space.setUpdateUserNick(user.getUserNick());


        spaceRepository.save(space);

        List<Wiki> wikis = wikiService.findBySpaceId(space.getSpaceId());

        Date now = new Date();

        for (Wiki wiki : wikis) {
            wiki.setDeleted(true);
            wiki.setUpdateDate(now);

            wikiService.save(wiki);
        }

        return space;
    }


    public UserFavorite bindUserFavorite(Integer spaceId, Integer userId, boolean isDeleted) {
        UserFavorite userFavorite;
        userFavorite = new UserFavorite();
        userFavorite.setFavoriteType(FavoriteType.SPACE);
        userFavorite.setUserId(userId);
        userFavorite.setInsertDate(new Date());
        userFavorite.setSpaceId(spaceId);
        userFavorite.setDeleted(isDeleted);
        return userFavorite;
    }

    public void updateFavorite(UserFavorite userFavorite, boolean isDeleted) {
        userFavorite.setDeleted(isDeleted);
        userFavorite.setUpdateDate(new Date());
        userFavoriteService.save(userFavorite);
    }

    public List<PhotoMain> convertSpaceMain(List<Photo> spaces) {
        List<PhotoMain> spaceMainList = new ArrayList<>();
        for (Photo space : spaces) {
            Integer spaceId = space.getSpaceId();
            User spaceUser = userService.findByUserId(spaceId);
            List<Wiki> wikis = wikiService.findBySpaceId(spaceId);
            List<Keyword> keywords = keywordService.findBySpaceId(spaceId, false);
            PhotoMain spaceMain = new PhotoMain(space, wikis.size(), keywords, spaceUser);
            spaceMainList.add(spaceMain);
        }

        return spaceMainList;
    }


    @Override
    public PhotoWikiList findWikiPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition) {
        Page<Wiki> pages = wikiService.findPagingByIsDeleted(PageUtil.sortPageable(
                startIdx
                , endIdx
                , PageUtil.sortId("DESC", sortCondition))
                , isDeleted);

        List<PhotoWiki> spaceWikis = convertSpaceWikis(pages.getContent());
        PhotoWikiList spaceWikiList = new PhotoWikiList(pages.getNumber(), pages.getTotalPages(), pages.getTotalElements(), spaceWikis);

        return spaceWikiList;
    }

    private List<PhotoWiki> convertSpaceWikis(List<Wiki> content) {
        List<PhotoWiki> spaceWikis = new ArrayList<>();
        for (Wiki wiki : content) {
            List<Keyword> keywords = keywordService.findByWikiId(wiki.getWikiId(), false);
            User userInfo = userService.findByUserId(wiki.getInsertUserId());
            PhotoWiki spaceWiki = new PhotoWiki(wiki, userInfo, keywords, wiki.getReplyCount());
            spaceWikis.add(spaceWiki);
        }

        return spaceWikis;
    }

}
