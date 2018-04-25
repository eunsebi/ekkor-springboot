package com.libqa.web.view.photo;

import java.util.List;

import com.libqa.application.enums.SpaceView;
import com.libqa.web.domain.*;
import com.libqa.web.view.feed.DisplayDate;

import lombok.Getter;

/**
 * @Author : yion
 * @Date : 2015. 6. 21.
 * @Description :
 */
@Getter
public class PhotoMain {

    private Integer spaceId;
    private String title;
    private String titleImage;
    private String titleImagePath;
    private String description;
    private String descriptionMarkup;
    private SpaceView layoutType;
    private boolean isPrivate;
    private boolean isDeleted;
    private String insertDate;
    private String updateDate;
    private Integer insertUserId;
    private String insertUserNick;
    private Integer updateUserId;
    private String updateUserNick;
    private List<SpaceAccessUser> spaceAccessUsers;

    private List<Keyword> keywords;
    private int wikiCount;

    private User user;

    public PhotoMain(Photo space, int wikiCount, List keywords) {
        this.spaceId = space.getSpaceId();
        this.title = space.getTitle();
        this.titleImage = space.getTitleImage();
        this.titleImagePath = space.getTitleImagePath();
        this.description = space.getDescription();
        this.descriptionMarkup = space.getDescriptionMarkup();
        this.layoutType = space.getLayoutType();
        this.isPrivate = space.isPrivate();
        this.isDeleted = space.isDeleted();
        this.insertDate = DisplayDate.parse(space.getInsertDate());
        this.updateDate = DisplayDate.parse(space.getUpdateDate());
        this.insertUserId = space.getInsertUserId();
        this.insertUserNick = space.getInsertUserNick();
        this.updateUserId = space.getUpdateUserId();
        this.updateUserNick = space.getUpdateUserNick();
        this.spaceAccessUsers = space.getSpaceAccessUsers();
        this.wikiCount = wikiCount;
        this.keywords = keywords;
    }

    public PhotoMain(Photo space, int wikiCount, List keywords, User user) {
        this.spaceId = space.getSpaceId();
        this.title = space.getTitle();
        this.titleImage = space.getTitleImage();
        this.titleImagePath = space.getTitleImagePath();
        this.description = space.getDescription();
        this.descriptionMarkup = space.getDescriptionMarkup();
        this.layoutType = space.getLayoutType();
        this.isPrivate = space.isPrivate();
        this.isDeleted = space.isDeleted();
        this.insertDate = DisplayDate.parse(space.getInsertDate());
        this.updateDate = DisplayDate.parse(space.getUpdateDate());
        this.insertUserId = space.getInsertUserId();
        this.insertUserNick = space.getInsertUserNick();
        this.updateUserId = space.getUpdateUserId();
        this.updateUserNick = space.getUpdateUserNick();
        this.spaceAccessUsers = space.getSpaceAccessUsers();
        this.wikiCount = wikiCount;
        this.keywords = keywords;
        this.user = user;
    }



}
