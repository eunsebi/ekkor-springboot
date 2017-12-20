package com.libqa.web.service.wiki;

import com.google.common.base.MoreObjects;
import com.libqa.application.enums.ActivityType;
import com.libqa.application.enums.KeywordType;
import com.libqa.application.enums.WikiRevisionActionType;
import com.libqa.application.util.LibqaConstant;
import com.libqa.application.util.PageUtil;
import com.libqa.web.domain.*;
import com.libqa.web.repository.KeywordRepository;
import com.libqa.web.repository.WikiLikeRepository;
import com.libqa.web.repository.WikiRepository;
import com.libqa.web.repository.WikiSnapShotRepository;
import com.libqa.web.service.common.ActivityService;
import com.libqa.web.service.common.KeywordService;
import com.libqa.web.service.user.UserService;
import com.libqa.web.view.wiki.DisplayWiki;
import com.libqa.web.view.wiki.DisplayWikiLike;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by songanji on 2015. 3. 1..
 */
@Service
@Slf4j
public class WikiServiceImpl implements WikiService {
    @Autowired
    WikiRepository wikiRepository;

    @Autowired
    WikiSnapShotRepository wikiSnapShotRepository;

    @Autowired
    KeywordRepository keywordRepository;

    @Autowired
    private WikiFileService wikiFileService;

    @Autowired
    private KeywordService keywordService;

    @Autowired
    private WikiReplyService wikiReplyService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private WikiLikeRepository wikiLikeRepository;

    @Autowired
    private UserService userService;

    final boolean isDeleted = false;

    @Override
    public Wiki save(Wiki wiki) {
        return wikiRepository.save(wiki);
    }

    @Override
    @Transactional
    public Wiki saveWithKeyword(Wiki wiki, Keyword keyword) {
        List<WikiFile> wikiFiles = wiki.getWikiFiles();
        Wiki result = save(wiki);
        result.setWikiFiles(wikiFiles);

        saveWikiFileAndList(result);
        saveKeywordAndList(keyword, result.getWikiId());
        saveWikiActivity(result, ActivityType.INSERT_WIKI);

        if (wiki.getParentsId() == null) {
            updateParentWikiId(result);
        }
        return result;
    }

    private void updateParentWikiId(Wiki wiki) {
        wiki.setParentsId(wiki.getWikiId());
        wiki.setGroupIdx(wiki.getWikiId());
        save(wiki);
    }

    private void saveWikiActivity(Wiki saveWiki, ActivityType ActivityType) {
        Activity activity = new Activity();
        activity.setInsertDate(new Date());
        activity.setDeleted(false);
        activity.setActivityType(ActivityType);
        activity.setActivityDesc(ActivityType.getCode());
        activity.setActivityKeyword(KeywordType.WIKI);
        activity.setUserId(saveWiki.getUpdateUserId());
        activity.setUserNick(saveWiki.getUpdateUserNick());
        activity.setWikiId(saveWiki.getWikiId());
        activityService.saveActivity(activity, saveWiki.getTitle());
    }

    @Override
    @Transactional
    public Wiki updateWithKeyword(Wiki wiki, Keyword keyword, WikiRevisionActionType revisionActionTypeEnum) {
        List<WikiFile> wikiFiles = wiki.getWikiFiles() == null ? new ArrayList<>() : new ArrayList<>(wiki.getWikiFiles());

        WikiSnapShot wikiSnapShot = new WikiSnapShot();
        BeanUtils.copyProperties(wiki, wikiSnapShot);

        wikiSnapShot.setWiki(wiki);
        wikiSnapShot.setRevisionActionType(revisionActionTypeEnum);
        wikiSnapShotRepository.save(wikiSnapShot);

        Wiki result = save(wiki);
        result.setWikiFiles(wikiFiles);
        saveWikiActivity(wiki, ActivityType.UPDATE_WIKI);

        saveWikiFileAndList(result);
        saveKeywordAndList(keyword, result.getWikiId());
        return result;
    }

    private void saveWikiFileAndList(Wiki wiki) {
        List<WikiFile> wikiFiles = wiki.getWikiFiles();
        if (wikiFiles != null && wikiFiles.size() > 0) {
            for (WikiFile wikiFile : wikiFiles) {
                if (wikiFile.getFileId() == null || wikiFile.isDeleted()) {
                    wikiFile.setInsertDate(wiki.getInsertDate());
                    wikiFile.setUserId(wiki.getInsertUserId());
                    wikiFile.setWikiId(wiki.getWikiId());
                    wikiFileService.saveWikiFileAndList(wikiFile);
                }

            }
        }
    }

    private void saveKeywordAndList(Keyword keyword, Integer wikiId) {
        if (!"".equals(keyword.getKeywordName())) {
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
                keywordService.saveKeywordAndList(keywordArrays, deleteKeywordArrays, KeywordType.WIKI, wikiId);
            }
        }
    }

    @Override
    public Wiki findById(Integer wikiId) {
        return wikiRepository.findByWikiIdAndIsDeleted(wikiId, isDeleted);
    }

    @Override
    public Wiki wikiDetail(Integer wikiId) {
        Wiki wiki = findById(wikiId);
        if (wiki != null) {
            wiki.setViewCount(MoreObjects.firstNonNull(wiki.getViewCount(), 0) + 1);
            save(wiki);
        }
        return wiki;
    }


    @Override
    public List<DisplayWiki> findByAllWiki(int page, int size, String sortType) {
        List<DisplayWiki> resultWiki = new ArrayList<>();
        List<Wiki> list = wikiRepository.findAllByIsDeleted(
                isDeleted
                , PageUtil.sortPageable(page, size, PageUtil.sortId("DESC", sortType))
        );
        if (!CollectionUtils.isEmpty(list)) {
            for (Wiki wiki : list) {
                resultWiki.add(new DisplayWiki(
                                wiki
                                , userService.findByUserId(wiki.getUpdateUserId())
                                , keywordService.findByWikiId(wiki.getWikiId(), false)
                        )
                );
            }
        }
        return resultWiki;
    }

    @Override
    public List<DisplayWiki> findByBestWiki(int page, int size) {
        List<DisplayWiki> resultWiki = new ArrayList<DisplayWiki>();
        List<Wiki> list = wikiRepository.findAllByIsDeleted(
                isDeleted
                , PageUtil.sortPageable(page, size, PageUtil.sortId("DESC", "likeCount"))
        );

        if (!CollectionUtils.isEmpty(list)) {
            for (Wiki wiki : list) {
                resultWiki.add(new DisplayWiki(
                                wiki
                                , userService.findByUserId(wiki.getUpdateUserId())
                                , keywordService.findByWikiId(wiki.getWikiId(), false)
                        )
                );
            }
        }

        return resultWiki;
    }

    @Override
    public List<DisplayWiki> findByRecentWiki(int userId, int page, int size) {
        List<DisplayWiki> resultWiki = new ArrayList<DisplayWiki>();
        List<Wiki> list = wikiRepository.findAllByUserIdAndIsDeleted(
                userId
                , isDeleted
                , PageUtil.sortPageable(
                        page
                        , size
                        , PageUtil.sort(PageUtil.order("DESC", "userId"), PageUtil.order("DESC", LibqaConstant.SORT_TYPE_DATE))
                )
        );

        if (!CollectionUtils.isEmpty(list)) {
            for (Wiki wiki : list) {
                resultWiki.add(new DisplayWiki(
                                wiki
                                , userService.findByUserId(wiki.getUpdateUserId())
                                , keywordService.findByWikiId(wiki.getWikiId(), false)
                        )
                );
            }
        }

        return resultWiki;
    }

    @Override
    public List<Wiki> findAllByCondition() {
        return wikiRepository.findAllByIsDeleted(PageUtil.sortId("ASC", "wikiId"), isDeleted);
    }

    @Override
    public List<Wiki> findBySpaceId(Integer spaceId) {
        return wikiRepository.findBySpaceIdAndIsDeleted(spaceId, isDeleted);
    }

    @Override
    public List<Wiki> findSortAndModifiedBySpaceId(Integer spaceId, int startIdx, int endIdx) {
        List wikis = new ArrayList<>();
        try {
            wikis = wikiRepository.findAllBySpaceIdAndIsDeleted(spaceId, isDeleted,
                    PageUtil.sortPageable(startIdx, endIdx, PageUtil.sortId("DESC", LibqaConstant.SORT_TYPE_DATE)));
        } catch (Exception e) {
            e.getMessage();
        }

        return wikis;
    }

    @Override
    public List<DisplayWiki> findWikiListByKeyword(String keywordNm, int page, int size) {
        List<DisplayWiki> resultWiki = new ArrayList<>();
        List<Keyword> keywordList = keywordRepository.findAllByKeywordTypeAndKeywordNameAndIsDeleted(KeywordType.WIKI, keywordNm, false);
        List<Integer> wikiIds = getWikiIdByKeyworld(keywordList);

        List<Wiki> list = wikiRepository.findAllByWikiIdInAndIsDeleted(
                wikiIds
                , isDeleted
                , PageUtil.sortPageable(
                        page
                        , size
                        , PageUtil.sortId("DESC", "insertDate")
                )
        );

        if (!CollectionUtils.isEmpty(list)) {
            for (Wiki wiki : list) {
                resultWiki.add(new DisplayWiki(
                                wiki
                                , userService.findByUserId(wiki.getUpdateUserId())
                                , keywordService.findByWikiId(wiki.getWikiId(), false)
                        )
                );
            }
        }


        return resultWiki;
    }

    @Override
    public List<DisplayWiki> findWikiListByContentsMarkup(String searchText, int page, int size) {
        List<DisplayWiki> resultWiki = new ArrayList<>();
        List<Wiki> list = wikiRepository.findAllByContentsMarkupContainingAndIsDeleted(
                searchText
                , isDeleted
                , PageUtil.sortPageable(
                        page
                        , size
                        , PageUtil.sortId("DESC", "insertDate")
                )
        );
        if( !CollectionUtils.isEmpty( list )){
            for( Wiki wiki : list ){
                resultWiki.add( new DisplayWiki(
                                wiki
                                , userService.findByUserId( wiki.getUpdateUserId() )
                                , keywordService.findByWikiId(wiki.getWikiId(), false)
                        )
                );
            }
        }
        return resultWiki;
    }

    @Override
    public DisplayWikiLike updateLike(WikiLike like) {
        DisplayWikiLike result = new DisplayWikiLike(0, null);
        try {
            WikiLike dupLike = null;
            if (like.getWikiId() != null) {
                dupLike = wikiLikeRepository.findOneByUserIdAndWikiId(like.getUserId(), like.getWikiId());
            } else if (like.getReplyId() != null) {
                dupLike = wikiLikeRepository.findOneByUserIdAndReplyId(like.getUserId(), like.getReplyId());
            }

            if (dupLike == null) {
                if (like.getWikiId() != null) {
                    Wiki wiki = findById(like.getWikiId());
                    wiki.setLikeCount(MoreObjects.firstNonNull(wiki.getLikeCount(), 0) + 1);
                    save(wiki);
                } else if (like.getReplyId() != null) {
                    WikiReply wikiReply = wikiReplyService.findById(like.getReplyId());
                    wikiReply.setLikeCount(MoreObjects.firstNonNull(wikiReply.getLikeCount(), 0) + 1);
                    wikiReplyService.update(wikiReply);
                }
                wikiLikeRepository.save(like);
                result.setResult(1);
                result.setWikiLike(like);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    private List<Integer> getWikiIdByKeyworld(List<Keyword> keywords) {
        List<Integer> wikiIds = new ArrayList<>();
        for (Keyword keyword : keywords) {
            wikiIds.add(keyword.getWikiId());
        }
        return wikiIds;
    }

    @Override
    public List<Wiki> searchRecentlyWikiesByPageSize(Integer pageSize) {
        final Integer startIndex = 0;
        final Sort sort = PageUtil.sortId("DESC", "wikiId");
        PageRequest pageRequest = PageUtil.sortPageable(startIndex, pageSize, sort);
        return wikiRepository.findAllByIsDeletedFalse(pageRequest);
    }


    @Override
    public Integer maxOrderIdx(Integer parentsId, Integer depthIdx) {
        List<Wiki> maxOrder = wikiRepository.findByParentsIdAndDepthIdxAndIsDeleted(
                parentsId, depthIdx, isDeleted
                , PageUtil.sortPageable(
                        0
                        , 1
                        , PageUtil.sortId("DESC", "orderIdx")
                ));
        return maxOrder == null || maxOrder.size() <= 0 ? 0 : maxOrder.get(0).getOrderIdx();
    }

    @Override
    public List<Wiki> findByGroupIdxAndOrderIdxGreaterThanAndIsDeleted(Integer groupIdx, Integer maxOrderIdx) {
        return wikiRepository.findByGroupIdxAndOrderIdxGreaterThanEqualAndIsDeleted(groupIdx, maxOrderIdx, isDeleted);
    }

    @Override
    public List<Wiki> findBySpaceIdAndSort(Integer spaceId) {

        List<Wiki> trees = wikiRepository.findAllBySpaceIdAndIsDeleted(spaceId, isDeleted, PageUtil.sort(PageUtil.order("ASC", "groupIdx"), PageUtil.order("ASC", "orderIdx")));
        return trees;
    }

    @Override
    public Page<Wiki> findPagingByIsDeleted(Pageable pageable, boolean isDeleted) {
        return wikiRepository.findPagingByIsDeleted(pageable, isDeleted);
    }

    @Override
    public List<Wiki> findAllLatestWikiBySpaceId(Integer pageSize, Integer spaceId) {
        PageRequest pageRequest = PageUtil.sortPageable(pageSize, PageUtil.sortId("DESC", "wikiId"));
        return wikiRepository.findAllBySpaceIdAndIsDeletedFalse(pageRequest, spaceId);
    }
}
