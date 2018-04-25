package com.libqa.web.service.photo;

import java.util.List;

import com.libqa.application.enums.ActivityType;
import com.libqa.web.domain.Keyword;
import com.libqa.web.domain.Photo;
import com.libqa.web.domain.User;
import com.libqa.web.view.photo.PhotoMain;
import com.libqa.web.view.photo.PhotoMainList;
import com.libqa.web.view.photo.PhotoWikiList;

/**
 * Created by yion on 2015. 3. 1..
 */
public interface PhotoService {

    Photo save(Photo space);

    /**
     * 삭제되지 않은 공간 목록 조회
     *
     * @param isDeleted
     * @return
     */
    List<Photo> findAllByCondition(boolean isDeleted);

    /**
     * 페이징
     *
     * @param isDeleted
     * @param startIdx
     * @param endIdx
     * @return
     */
    List<Photo> findAllByCondition(boolean isDeleted, Integer startIdx, Integer endIdx);

    /**
     * 페이징 및 정렬 조건
     *
     * @param isDeleted
     * @param startIdx
     * @param endIdx
     * @param sortCondition
     * @return
     */
    PhotoMainList findPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition);

    Photo findOne(Integer spaceId);

    Photo saveWithKeyword(Photo space, Keyword keyword, ActivityType activityType);

    /**
     * 사용자가 추가한 즐겨찾기 공간 목록 조회
     *
     * @param userId
     * @return
     */
    List<Photo> findUserFavoriteSpace(Integer userId, boolean isDeleted);

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
    Photo delete(Photo space, User user);

    List<PhotoMain> convertSpaceMain(List<Photo> spaces);

    PhotoWikiList findWikiPageBySort(boolean isDeleted, Integer startIdx, Integer endIdx, String sortCondition);
}
