package com.libqa.web.service.space;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by yion on 2015. 3. 1..
 */
@Slf4j
@Service
public class SpaceServiceImpl implements SpaceService {

    @Autowired
    private SpaceRepository spaceRepository;

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
    public Space save(Space space) {
        return spaceRepository.save(space);
    }

    @Override
    public List<Space> findAllByCondition(boolean isDeleted) {
        return this.findAllByCondition(isDeleted, null, null);
    }


    @Override
    public List<Space> findAllByCondition(boolean isDeleted, Integer startNum, Integer pageSize) {
        if (startNum == null) {
            return spaceRepository.findAllByIsDeleted(PageUtil.sortId("DESC", "spaceId"), isDeleted);
        } else {
            Page<Space> pages = spaceRepository.findPagingByIsDeleted(
                    PageUtil.sortPageable(
                            startNum
                            , pageSize
                            , PageUtil.sortId("DESC", "spaceId"))
                    , isDeleted);

            return pages.getContent();
        }
    }


    @Override
    public SpaceMainList findPageBySort(boolean isDeleted, Integer startNum, Integer pageSize, String sortCondition) {
        Page<Space> pages;

        pages = spaceRepository.findPagingByIsDeleted(
                PageUtil.sortPageable(
                        startNum
                        , pageSize
                        , PageUtil.sortId("DESC", sortCondition))
                , isDeleted);

        List<SpaceMain> spaceMains = convertSpaceMain(pages.getContent());
        SpaceMainList spaceMainList = new SpaceMainList(pages.getNumber(), pages.getTotalPages(), pages.getTotalElements(), spaceMains);
        return spaceMainList;
    }

    @Override
    public Space findOne(Integer spaceId) {
        return spaceRepository.findOne(spaceId);
    }

    @Override
    public Space saveWithKeyword(Space space, Keyword keyword, ActivityType activityType) {
        Space result = save(space);

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

    private void saveActivities(Space result, ActivityType activityType) {
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
    public List<Space> findUserFavoriteSpace(Integer userId, boolean isDeleted) {

        List<UserFavorite> userFavoriteList;

        userFavoriteList = userFavoriteService.findByFavoriteTypeAndUserIdAndIsDeleted(FavoriteType.SPACE, userId, isDeleted);

        if (userFavoriteList.isEmpty()) {
            return null;
        }

        List<Space> mySpaceList = new ArrayList<>();
        for (UserFavorite favorite : userFavoriteList) {
            Space space = spaceRepository.findOne(favorite.getSpaceId());

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
    public Space delete(Space space, User user) {
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

    public List<SpaceMain> convertSpaceMain(List<Space> spaces) {
        List<SpaceMain> spaceMainList = new ArrayList<>();
        for (Space space : spaces) {
            Integer spaceId = space.getSpaceId();
            User spaceUser = userService.findByUserId(spaceId);
            List<Wiki> wikis = wikiService.findBySpaceId(spaceId);
            List<Keyword> keywords = keywordService.findBySpaceId(spaceId, false);
            SpaceMain spaceMain = new SpaceMain(space, wikis.size(), keywords, spaceUser);
            spaceMainList.add(spaceMain);
        }

        return spaceMainList;
    }


    @Override
    public SpaceWikiList findWikiPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition) {
        Page<Wiki> pages = wikiService.findPagingByIsDeleted(PageUtil.sortPageable(
                startIdx
                , endIdx
                , PageUtil.sortId("DESC", sortCondition))
                , isDeleted);

        List<SpaceWiki> spaceWikis = convertSpaceWikis(pages.getContent());
        SpaceWikiList spaceWikiList = new SpaceWikiList(pages.getNumber(), pages.getTotalPages(), pages.getTotalElements(), spaceWikis);

        return spaceWikiList;
    }

    private List<SpaceWiki> convertSpaceWikis(List<Wiki> content) {
        List<SpaceWiki> spaceWikis = new ArrayList<>();
        for (Wiki wiki : content) {
            List<Keyword> keywords = keywordService.findByWikiId(wiki.getWikiId(), false);
            User userInfo = userService.findByUserId(wiki.getInsertUserId());
            SpaceWiki spaceWiki = new SpaceWiki(wiki, userInfo, keywords, wiki.getReplyCount());
            spaceWikis.add(spaceWiki);
        }

        return spaceWikis;
    }

}
