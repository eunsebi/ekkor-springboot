package com.libqa.web.service.space;

import com.libqa.application.enums.ActivityType;
import com.libqa.web.domain.Keyword;
import com.libqa.web.domain.Space;
import com.libqa.web.domain.User;
import com.libqa.web.view.space.SpaceMain;
import com.libqa.web.view.space.SpaceMainList;
import com.libqa.web.view.space.SpaceWikiList;

import java.util.List;

/**
 * Created by yion on 2015. 3. 1..
 */
public interface SpaceService {

    Space save(Space space);

    /**
     * 삭제되지 않은 공간 목록 조회
     *
     * @param isDeleted
     * @return
     */
    List<Space> findAllByCondition(boolean isDeleted);

    /**
     * 페이징
     *
     * @param isDeleted
     * @param startIdx
     * @param endIdx
     * @return
     */
    List<Space> findAllByCondition(boolean isDeleted, Integer startIdx, Integer endIdx);

    /**
     * 페이징 및 정렬 조건
     *
     * @param isDeleted
     * @param startIdx
     * @param endIdx
     * @param sortCondition
     * @return
     */
    SpaceMainList findPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition);

    Space findOne(Integer spaceId);

    Space saveWithKeyword(Space space, Keyword keyword, ActivityType activityType);

    /**
     * 사용자가 추가한 즐겨찾기 공간 목록 조회
     *
     * @param userId
     * @return
     */
    List<Space> findUserFavoriteSpace(Integer userId, boolean isDeleted);

    /**
     * 즐겨 찾기 추가 (삭제)
     *
     * @param spaceId
     * @param userId
     * @param isDeleted
     * @return
     */
    Integer addSpaceFavorite(Integer spaceId, Integer userId, boolean isDeleted);

    Integer cancelSpaceFavorite(Integer spaceId, Integer userId, boolean isDeleted);

    /**
     * 삭제
     *
     * @param space
     * @param user
     * @return
     */
    Space delete(Space space, User user);

    List<SpaceMain> convertSpaceMain(List<Space> spaces);

    SpaceWikiList findWikiPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition);
}
