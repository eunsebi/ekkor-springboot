package com.libqa.web.service.qa;

import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import com.libqa.web.domain.QaContent;
import com.libqa.web.domain.QaReply;
import com.libqa.web.domain.User;
import com.libqa.web.domain.Vote;
import com.libqa.web.repository.QaReplyRepository;
import com.libqa.web.service.user.UserService;
import com.libqa.web.view.qa.DisplayQaReply;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by yong on 2015-04-12.
 *
 * @author yong
 */
@Slf4j
@Service
public class QaReplyServiceImpl implements QaReplyService {

    @Autowired
    QaService qaService;

    @Autowired
    QaReplyRepository qaReplyRepository;

    @Autowired
    VoteService voteService;

    @Autowired
    UserService userService;

    @Override
    public QaReply findByReplyId(Integer replyId) {
        return qaReplyRepository.findByReplyIdAndIsDeletedFalse(replyId);
    }

    @Override
    public int getCountByQaId(Integer qaId) {
        return qaReplyRepository.countByQaIdAndIsDeletedFalse(qaId);
    }

    @Override
    @Transactional
    public void updateReply(QaReply qaReply, User user) {
        QaReply originQaReply = findByReplyId(qaReply.getReplyId());
        originQaReply.setTitle(qaReply.getTitle());
        originQaReply.setContents(qaReply.getContents());
        originQaReply.setContentsMarkup(qaReply.getContentsMarkup());
        originQaReply.setUpdateDate(new Date());
        originQaReply.setUpdateUserId(user.getUserId());
    }

    @Override
    public Integer getCountByQaIdAndIsChoice(Integer qaId) {
        return qaReplyRepository.countByQaIdAndIsChoiceTrueAndIsDeletedFalse(qaId);
    }

    @Override
    @Transactional
    public void saveReplyChoice(Integer replyId, Integer userId) {
        QaReply originQaReply = findByReplyId(replyId);
        originQaReply.setChoice(true);
        originQaReply.setUpdateDate(new Date());
        originQaReply.setUpdateUserId(userId);
    }

    @Override
    public List<DisplayQaReply> findByQaIdAndIsChoiceAndDepthIdx(Integer qaId, boolean isChoice, int depthIdx, User viewer) {
        List<QaReply> qaReplyList = qaReplyRepository.findByQaIdAndIsChoiceAndDepthIdxAndIsDeletedFalse(qaId, isChoice, depthIdx);
        return makeDisplayQaReply(qaReplyList, depthIdx, viewer);
    }

    @Override
    @Transactional
    public QaReply saveWithQaContent(QaReply paramQaReply, User user) {
        boolean isDeleted = false;
        boolean isReplyed = true;

        List<QaReply> parentQaReplyList = qaReplyRepository.findAllByQaIdAndIsDeletedOrderByOrderIdxDesc(paramQaReply.getQaId(), isDeleted);
        QaReply parentQaReply = Iterables.getFirst(parentQaReplyList, null);
        Integer orderIdx = parentQaReply == null ? 1 : parentQaReply.getOrderIdx() + 1;
        paramQaReply.setInsertDate(new Date());
        paramQaReply.setInsertUserId(user.getUserId());
        paramQaReply.setUserId(user.getUserId());
        paramQaReply.setUserNick(user.getUserNick());
        paramQaReply.setOrderIdx(orderIdx);
        QaReply newQaReply = qaReplyRepository.save(paramQaReply);

        newQaReply.setParentsId(newQaReply.getReplyId());
        newQaReply.setUpdateDate(new Date());
        newQaReply.setUpdateUserId(user.getUserId());
        qaService.saveIsReplyed(paramQaReply.getQaId(), user.getUserId(), isReplyed);
        return newQaReply;
    }

    @Override
    public QaReply saveVoteUp(QaReply paramQaReply, Integer userId, String userNick) {
        return saveVote(paramQaReply, userId, userNick, "UP");
    }

    @Override
    public QaReply saveVoteDown(QaReply paramQaReply, Integer userId, String userNick) {
        return saveVote(paramQaReply, userId, userNick, "DOWN");
    }

    public QaReply saveVote(QaReply paramQaReply, Integer userId, String userNick, String voteType) {
        boolean isDeleted = false;
        boolean isCancel = false;
        boolean isVote;
        boolean saveVoteValid = true;
        QaReply qaReply = qaReplyRepository.findByReplyIdAndIsDeleted(paramQaReply.getReplyId(), isDeleted);

        Vote vote = voteService.findByReplyIdAndUserIdAndIsCancel(paramQaReply.getReplyId(), userId, isCancel);
        int voteUpCount = qaReply.getVoteUpCount();
        int voteDownCount = qaReply.getVoteDownCount();

        if (vote != null) {
            voteService.deleteByQaReply(qaReply, userId);
            if (vote.getIsVote()) {
                voteUpCount -= 1;
            } else {
                voteDownCount -= 1;
            }
        }

        if ("UP".equals(voteType)) {
            isVote = true;
            voteUpCount += 1;
        } else {
            isVote = false;
            voteDownCount += 1;
        }
        voteService.saveByQaReply(qaReply, userId, userNick, isVote);

        qaReply.setVoteUpCount(voteUpCount);
        qaReply.setVoteDownCount(voteDownCount);
        qaReplyRepository.save(qaReply);

        return qaReply;
    }

    @Override
    public QaReply saveChildReply(QaReply paramQaReply, User user) {
        Date today = new Date();
        paramQaReply.setInsertDate(today);
        paramQaReply.setUpdateDate(today);
        paramQaReply.setInsertUserId(user.getUserId());
        paramQaReply.setUpdateUserId(user.getUserId());
        paramQaReply.setUserId(user.getUserId());
        paramQaReply.setUserNick(user.getUserNick());

        paramQaReply.setContentsMarkup(paramQaReply.getContents());
        paramQaReply.setOrderIdx(paramQaReply.getOrderIdx() + 1);
        paramQaReply.setDepthIdx(paramQaReply.getDepthIdx() + 1);
        return qaReplyRepository.save(paramQaReply);
    }

    @Override
    public List<DisplayQaReply> findByQaIdAndDepthIdx(Integer qaId, int depthIdx, User viewer) {
        boolean isDeleted = false;
        int qaReplyDepth = 1;
        List<QaReply> qaReplyList = qaReplyRepository.findAllByQaIdAndDepthIdxAndIsDeletedOrderByReplyIdAsc(qaId, depthIdx, isDeleted);
        return makeDisplayQaReply(qaReplyList, qaReplyDepth, viewer);
    }

    public List<DisplayQaReply> makeDisplayQaReply(List<QaReply> qaReplyList, int qaReplyDepth, User viewer) {
        List<DisplayQaReply> displayQaReplyList = Lists.newArrayList();
        List<DisplayQaReply> displaySubQaReplyList = Lists.newArrayList();
        for (QaReply qaReply : qaReplyList) {
            User writer = userService.findByUserId(qaReply.getUserId());
            List<Vote> votes = voteService.findByReplyIdAndIsVote(qaReply.getReplyId(), true);
            List<Vote> nonVotes = voteService.findByReplyIdAndIsVote(qaReply.getReplyId(), false);
            boolean selfRecommend = voteService.hasRecommendUser(qaReply.getReplyId(), viewer.getUserId());
            boolean selfNonrecommend = voteService.hasNonRecommendUser(qaReply.getReplyId(), viewer.getUserId());
            if (1 == qaReplyDepth) {
                displaySubQaReplyList = findByQaIdAndParentsIdAndDepthIdx(qaReply.getQaId(), qaReply.getReplyId(), 2, viewer);
            }
            final boolean isWriter = writer.isMatchUser(viewer.getUserId());
            displayQaReplyList.add(new DisplayQaReply(qaReply, displaySubQaReplyList, votes, nonVotes, selfRecommend, selfNonrecommend, writer, isWriter));
        }
        return displayQaReplyList;
    }

    public List<DisplayQaReply> findByQaIdAndParentsIdAndDepthIdx(Integer qaId, Integer replyId, int depthIdx, User viewer) {
        boolean isDeleted = false;
        List<QaReply> qaReplyList = qaReplyRepository.findAllByQaIdAndParentsIdAndDepthIdxAndIsDeletedOrderByOrderIdxAsc(qaId, replyId, depthIdx, isDeleted);
        int qaReplyDepth = 2;
        return makeDisplayQaReply(qaReplyList, qaReplyDepth, viewer);
    }

    @Override
    @Transactional
    public void delete(Integer replyId, Integer userId) {
        QaReply qaReply = qaReplyRepository.findOne(replyId);
        qaReply.setDeleted(true);
        qaReply.setUpdateUserId(userId);
        qaReply.setUpdateDate(new Date());
        if( 0 == countByQaContent(qaReply.getQaId())){
            boolean isReplyed = false;
            qaService.saveIsReplyed(qaReply.getQaId(), userId, isReplyed);
        }
    }

    @Override
    public List<QaReply> findByQaId(Integer qaId) {
        return qaReplyRepository.findByQaIdAndIsDeletedFalse(qaId);
    }

    @Override
    public List<QaContent> findByUserId(Integer userId) {
        List<Integer> qaIds = new ArrayList<Integer>();
        List<QaReply> qaReplyList = qaReplyRepository.findByUserIdAndIsDeleted(userId, false);
        for (QaReply qaReply : qaReplyList) {
            qaIds.add(qaReply.getQaId());
        }

        return qaService.findByQaIdIn(qaIds);
    }

    @Override
    public Integer countByQaContent(Integer qaId) {
        return qaReplyRepository.countByQaIdAndIsDeletedFalse(qaId);
    }


    public void updateOrderIdx(QaReply paramQaReply) {
        boolean isDeleted = false;
        List<QaReply> updateTargetQaReplyList = qaReplyRepository.findAllByQaIdAndIsDeletedAndOrderIdxGreaterThanOrderByOrderIdxAsc(paramQaReply.getQaId(), isDeleted, paramQaReply.getOrderIdx());
        for (QaReply qaReply : updateTargetQaReplyList) {
            qaReply.setOrderIdx(qaReply.getOrderIdx() + 1);
            qaReplyRepository.flush();
        }
    }
}
