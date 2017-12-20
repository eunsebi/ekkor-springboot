package com.libqa.web.service.qa;

import com.google.common.collect.Lists;
import com.libqa.application.dto.QaDto;
import com.libqa.application.enums.DayType;
import com.libqa.application.enums.KeywordType;
import com.libqa.application.enums.QaSearchType;
import com.libqa.application.enums.WaitReplyType;
import com.libqa.application.util.PageUtil;
import com.libqa.web.domain.Keyword;
import com.libqa.web.domain.QaContent;
import com.libqa.web.domain.QaFile;
import com.libqa.web.domain.User;
import com.libqa.web.repository.QaContentRepository;
import com.libqa.web.service.common.KeywordListService;
import com.libqa.web.service.common.KeywordService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

import static org.springframework.data.domain.Sort.Direction.DESC;

/**
 * Created by yong on 2015-03-08.
 *
 * @author yong
 */
@Slf4j
@Service
public class QaServiceImpl implements QaService {

    private static final Sort DEFAULT_SORT = new Sort(DESC, "qaId");

    @Autowired
    QaContentRepository qaRepository;

    @Autowired
    KeywordService keywordService;

    @Autowired
    KeywordListService keywordListService;

    @Autowired
    QaFileService qaFileService;

    @Override
    @Transactional
    public QaContent saveWithKeyword(QaContent paramQaContent, QaFile qaFiles, Keyword keyword, User user) {
        QaContent newQaContent = new QaContent();
        try {

            paramQaContent.setUserId(user.getUserId());
            paramQaContent.setUserNick(user.getUserNick());
            paramQaContent.setInsertUserId(user.getUserId());
            Date today = new Date();
            paramQaContent.setInsertDate(today);
            paramQaContent.setUpdateDate(today);

            newQaContent = save(paramQaContent);
            moveQaFilesToProductAndSave(newQaContent.getQaId(), qaFiles);
            saveKeywordAndList(newQaContent.getQaId(), keyword.getKeywords(), keyword.getDeleteKeywords());
        } catch (Exception e) {
            log.error("### moveQaFilesToProductAndSave Exception = {}", e);
            throw new RuntimeException("moveQaFilesToProductAndSave Exception");
        }
        return newQaContent;
    }

    @Override
    @Transactional
    public boolean deleteWithKeyword(Integer qaId, Integer userId) {
        boolean result = false;
        try {
            delete(qaId, userId);
            keywordService.delete(qaId, userId);
            result = true;
        } catch (Exception e) {
            log.error("삭제시 오류 발생", e);
            result = false;
        }
        return result;
    }

    @Override
    public void saveIsReplyed(Integer qaId, Integer userId, boolean isReplyed) {
        QaContent targetQaContent = findByQaId(qaId, false);
        targetQaContent.setReplyed(isReplyed);
        targetQaContent.setUpdateUserId(userId);
        targetQaContent.setUpdateDate(new Date());
    }

    @Override
    public QaContent updateWithKeyword(QaContent originQaContent, QaContent requestQaContent, QaFile requestQaFiles, Keyword requestKeywords, User user) {
        try {
            originQaContent = update(originQaContent, requestQaContent, user);
            moveQaFilesToProductAndSave(originQaContent.getQaId(), requestQaFiles);
            saveKeywordAndList(originQaContent.getQaId(), requestKeywords.getKeywords(), requestKeywords.getDeleteKeywords());
        } catch (Exception e) {
            log.error("### moveQaFilesToProductAndSave Exception = {}", e);
            throw new RuntimeException("moveQaFilesToProductAndSave Exception");
        }
        return originQaContent;
    }

    private QaContent update(QaContent originQaContent, QaContent requestQaContent, User user) {
        originQaContent.setTitle(requestQaContent.getTitle());
        originQaContent.setUpdateUserId(user.getUserId());
        originQaContent.setUpdateDate(new Date());
        originQaContent.setContents(requestQaContent.getContents());
        originQaContent.setContentsMarkup(requestQaContent.getContentsMarkup());

        return originQaContent;
    }

    @Override
    public List<QaContent> findByUserId(Integer userId) {
        return qaRepository.findByUserIdAndIsDeleted(userId, false);
    }

    @Override
    public List<QaContent> findByQaIdIn(List<Integer> qaIds) {
        return qaRepository.findByQaIdInAndIsDeletedOrderByQaIdDesc(qaIds, false);
    }

    @Override
    @Transactional
    public QaContent view(Integer qaId) {
        QaContent qaContent = findByQaId(qaId, false);
        qaContent.setViewCount(qaContent.getViewCount() + 1);
        return qaContent;
    }

    @Override
    public List<QaContent> searchRecentlyQaContentsByPageSize(Integer pageSize) {
        final Sort sort = PageUtil.sortId("DESC", "qaId");
        PageRequest pageRequest = PageUtil.sortPageable(pageSize, sort);
        return qaRepository.findByIsDeletedFalse(pageRequest);
    }

    @Override
    public Integer getQaTotalCount() {
        return qaRepository.countByIsDeletedFalse();
    }

    @Override
    public Integer getQaNotReplyedCount() {
        return qaRepository.countByIsReplyedFalseAndIsDeletedFalse();
    }

    /**
     * BEST Q&A를 조회한다.
     * <br />
     * 추천수 desc, 비추천 asc로 sort 하여 최근 10개 추출함.
     *
     * @return list of QaContent
     */
    @Override
    public List<QaContent> getBestQaContents() {
        final Integer pageSize = 10;
        final Order order1 = new Order(Sort.Direction.DESC, "recommendCount");
        final Order order2 = new Order(Sort.Direction.ASC, "nonrecommendCount");
        PageRequest pageRequest = PageUtil.sortPageable(pageSize, new Sort(order1, order2));

        return qaRepository.findByIsDeletedFalse(pageRequest);
    }

    @Override
    public QaContent saveRecommendCount(Integer qaId, boolean commend, int calculationCnt) {
        QaContent qaContent = qaRepository.findByQaIdAndIsDeletedFalse(qaId);
        int preCount;
        if (commend) {
            preCount = qaContent.getRecommendCount();
            qaContent.setRecommendCount(preCount + calculationCnt);
        } else {
            preCount = qaContent.getNonrecommendCount();
            qaContent.setNonrecommendCount(preCount + calculationCnt);
        }
        return qaContent;
    }

    @Override
    public List<QaContent> getRecentQAContents() {
        Date today = new Date();
        Date fromDate = null;
        try {
            fromDate = getFromDate(DayType.WEEK);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        final Integer pageSize = 10;
        final Order order = new Order(Sort.Direction.DESC, "updateDate");
        PageRequest pageRequest = PageUtil.sortPageable(pageSize, new Sort(order));

        return qaRepository.findByUpdateDateBetweenAndIsDeletedFalse(fromDate, today, pageRequest);
    }

    @Override
    public List<QaContent> getWaitReplyQaContents() {
        final Integer pageSize = 10;
        final Order order = new Order(Sort.Direction.DESC, "updateDate");
        PageRequest pageRequest = PageUtil.sortPageable(pageSize, new Sort(order));

        return qaRepository.findByIsDeletedFalseAndIsReplyedFalse(pageRequest);
    }

    @Override
    public List<QaContent> getQaContents(QaSearchType qaSearchType) {
        PageRequest pageRequest = PageUtil.sortPageable(DEFAULT_SORT);
        if(QaSearchType.TOTAL == qaSearchType) {
            return qaRepository.findByIsDeletedFalse(pageRequest);
        } else if(QaSearchType.WAIT_REPLY == qaSearchType) {
            return qaRepository.findByIsDeletedFalseAndIsReplyedFalse(pageRequest);
        } else {
            return Lists.newArrayList();
        }
    }

    private List<QaContent> getQaContentsLessThanLastQaId(QaSearchType qaSearchType, Integer lastQaId) {
        PageRequest pageRequest = PageUtil.sortPageable(DEFAULT_SORT);
        try {
            if (QaSearchType.TOTAL == qaSearchType) {
                return qaRepository.findByQaIdLessThanAndIsDeletedFalse(lastQaId, pageRequest);
            } else if (QaSearchType.WAIT_REPLY == qaSearchType) {
                return qaRepository.findByQaIdLessThanAndIsReplyedFalseAndIsDeletedFalse(lastQaId, pageRequest);
            } else {
                return Lists.newArrayList();
            }
        } catch (Exception e){
            return Lists.newArrayList();
        }
    }

    @Override
    public List<QaContent> getQaContentsLessThanLastQaIdAndKeywordName(QaSearchType qaSearchType, QaDto qaDto) {
        PageRequest pageRequest = PageUtil.sortPageable(DEFAULT_SORT);
        try {
            if("".equals(qaDto.getKeywordName())){
                return getQaContentsLessThanLastQaId(qaSearchType, qaDto.getLastQaId());
            } else {
                if (QaSearchType.TOTAL == qaSearchType) {
                    return qaRepository.findFirst5ByQaIdLessThanAndKeywordTypeAndKeywordNameAndIsDeletedFalse(qaDto.getLastQaId(), qaDto.getKeywordType(), qaDto.getKeywordName());
                } else if (QaSearchType.WAIT_REPLY == qaSearchType) {
                    return qaRepository.findFirst5ByQaIdLessThanAndKeywordTypeAndKeywordNameAndIsReplyedFalseAndIsDeletedFalse(qaDto.getLastQaId(), qaDto.getKeywordType(), qaDto.getKeywordName());
                } else {
                    return Lists.newArrayList();
                }
            }
        } catch (Exception e){
            return Lists.newArrayList();
        }
    }

    void moveQaFilesToProductAndSave(Integer qaId, QaFile qaFiles) {
        qaFileService.moveQaFilesToProductAndSave(qaId, qaFiles);
    }

    void saveKeywordAndList(Integer qaId, String keywords, String deleteKeywords) {
        if (qaId != 0) {
            String[] keywordArrays = new String[0];
            String[] deleteKeywordArrays = new String[0];
            if (keywords != null) {
                keywordArrays = keywords.split(",");
            }
            if (deleteKeywords != null) {
                deleteKeywordArrays = deleteKeywords.split(",");
            }
            log.debug(" keywordArrays : {}", keywordArrays.length);
            log.debug(" deleteKeywordArrays : {}", deleteKeywordArrays.length);
            if (keywordArrays.length > 0 || deleteKeywordArrays.length > 0) {
                keywordService.saveKeywordAndList(keywordArrays, deleteKeywordArrays, KeywordType.QA, qaId);
            }
        }
    }

    /*
    public void saveKeywordAndList(Integer qaId, St) {
        if (qaContentInstance.getKeyword() != null) {
            int keywordListSize = qaContentInstance.getKeyword().size();
            String [] keywordArrays = (String[]) qaContentInstance.getKeyword().toArray(new String[keywordListSize]);
            keywordService.saveKeywordAndList(keywordArrays, KeywordTypeEnum.QA, newQaContent.getQaId());
        }
    }
    */

    public QaContent save(QaContent qaContent) {
        return qaRepository.save(qaContent);
    }

    private void delete(Integer qaId, Integer userId) {
        QaContent targetQaContent = findByQaId(qaId, false);
        targetQaContent.setDeleted(true);
        targetQaContent.setUpdateUserId(userId);
        targetQaContent.setUpdateDate(new Date());
    }

    @Override
    public QaContent findByQaId(Integer qaId, boolean isDeleted) {
        return qaRepository.findOneByQaIdAndIsDeleted(qaId, isDeleted);
    }

    @Override
    public List<QaContent> searchQaContents(QaDto qaDto) {
        boolean isReplyed = false;
        Date today = new Date();
        List<QaContent> returnQaContentObj = new ArrayList<>();
        Stream<QaContent> qaStream = null;
        try {
            Date fromDate = getFromDate(qaDto.getDayType());
            qaStream = getQaContentStream(qaDto, isReplyed, today, fromDate);
            qaStream.forEach(qaContent -> returnQaContentObj.add(qaContent));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnQaContentObj;
    }

    private Stream<QaContent> getQaContentStream(QaDto qaDto, boolean isReplyed, Date today, Date fromDate) {
        Stream<QaContent> qaStream;
        if ("".equals(qaDto.getKeywordName())) {
            if (WaitReplyType.WAIT == qaDto.getWaitReplyType()) {
                if (null == fromDate) {
                    qaStream = qaRepository.findAllByIsReplyedAndIsDeletedFalseOrderByUpdateDateDesc(isReplyed);
                } else {
                    qaStream = qaRepository.findAllByIsReplyedAndUpdateDateBetweenAndIsDeletedFalseOrderByUpdateDateDesc(isReplyed, fromDate, today);
                }
            } else {
                qaStream = qaRepository.findAllByUpdateDateBetweenAndIsDeletedFalseOrderByUpdateDateDesc(fromDate, today);
            }
        } else {
            if (WaitReplyType.WAIT == qaDto.getWaitReplyType()) {
                if (null == fromDate) {
                    if(QaSearchType.WAIT_REPLY == qaDto.getQaSearchType()){
                        qaStream = qaRepository.findFirst5ByKeywordAndIsReplyedAndDayTypeAndIsDeletedFalse(qaDto.getKeywordType(), qaDto.getKeywordName(), isReplyed);
                    } else {
                        qaStream = qaRepository.findAllByKeywordAndIsReplyedAndDayTypeAndIsDeletedFalse(qaDto.getKeywordType(), qaDto.getKeywordName(), isReplyed);
                    }
                } else {
                    qaStream = qaRepository.findAllByKeywordAndIsReplyedAndDayTypeAndIsDeletedFalseAndUpdateDateBetween(qaDto.getKeywordType(), qaDto.getKeywordName(), isReplyed, fromDate, today);
                }
            } else {
                if (null == fromDate) {
                    qaStream = qaRepository.findAllByKeywordAndIsDeletedFalse(qaDto.getKeywordType(), qaDto.getKeywordName());
                } else {
                    qaStream = qaRepository.findAllByKeywordAndDayTypeAndIsDeletedFalse(qaDto.getKeywordType(), qaDto.getKeywordName(), fromDate, today);
                }
            }
        }
        return qaStream;
    }

    public List<QaContent> findRecentList(List<Integer> qaIds, boolean isReplyed, Date fromDate, Date today, boolean isDeleted) {
        List<QaContent> recentList = new ArrayList<>();
        if (fromDate == null) {
            recentList = qaRepository.findAllByQaIdInAndIsReplyedAndIsDeletedOrderByUpdateDateDesc(qaIds, isReplyed, isDeleted);
        } else {
            recentList = qaRepository.findAllByQaIdInAndIsReplyedAndUpdateDateBetweenAndIsDeletedOrderByUpdateDateDesc(qaIds, isReplyed, fromDate, today, isDeleted);
        }
        return recentList;
    }

    public List<QaContent> findWaitList(List<Integer> qaIds, Date fromDate, Date today, boolean isDeleted) {
        return qaRepository.findAllByQaIdInAndUpdateDateBetweenAndIsDeletedOrderByUpdateDateDesc(qaIds, fromDate, today, isDeleted);
    }

    public Date getFromDate(DayType dayType) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date now = dateFormat.parse(dateFormat.format(new Date()));
        Date returnDate;
        if (DayType.WEEK == dayType) {
            returnDate = DateUtils.addDays(now, -7);
        } else if (DayType.ALL == dayType) {
            returnDate = null;
        } else {
            returnDate = now;
        }
        return returnDate;
    }

    public List<Integer> getQaIdByKeyword(String keywordName) {
        boolean isDeleted = false;
        List<Integer> qaIds = new ArrayList();
        List<Keyword> keywords = keywordService.findAllByKeywordTypeAndKeywordNameAndIsDeleted(KeywordType.QA, keywordName, isDeleted);
        for (Keyword keyword : keywords) {
            qaIds.add(keyword.getQaId());
        }
        return qaIds;
    }


}
