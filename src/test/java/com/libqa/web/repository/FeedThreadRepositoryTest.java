package com.libqa.web.repository;

import com.libqa.application.util.PageUtil;
import com.libqa.testsupport.LibqaRepositoryTest;
import com.libqa.web.domain.FeedThread;
import org.junit.Test;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.util.List;

import static org.fest.assertions.Assertions.assertThat;
import static org.springframework.data.domain.Sort.Direction.DESC;

public class FeedThreadRepositoryTest extends LibqaRepositoryTest<FeedThreadRepository> {

    @Test
    public void findOne() {
        FeedThread actual = repository.findOne(-1);
        assertThat(actual).isNull();
    }

    @Test
    public void findByFeedThreadIdLessThanAndIsDeletedFalse() {
        final int feedThreadId = 0;
        final PageRequest pageRequest = PageUtil.sortPageable(new Sort(DESC, "feedThreadId"));
        List<FeedThread> feedThreads = repository.findByFeedThreadIdLessThanAndIsDeletedFalse(feedThreadId, pageRequest);
        System.out.println(feedThreads);
    }

    @Test
    public void findByIsDeletedFalse() {
        final PageRequest pageRequest = new PageRequest(0, 5, new Sort(new Sort.Order(DESC, "feedThreadId")));
        List<FeedThread> feedThreads = repository.findByIsDeletedFalse(pageRequest);
        System.out.println(feedThreads);
    }

    @Test
    public void countFeedRepliesByFeedThreadId() {
        Integer count = repository.countFeedRepliesByFeedThreadId(-1);
        System.out.println(count);
    }

    @Test
    public void findByUserIdAndIsDeletedFalse() {
        final int userId = 100000;
        final PageRequest pageRequest = PageUtil.sortPageable(new Sort(DESC, "feedThreadId"));
        List<FeedThread> feedThreads = repository.findByUserIdAndIsDeletedFalse(userId, pageRequest);
        System.out.println(feedThreads);
    }


    @Test
    public void findByUserIdAndFeedThreadIdLessThanAndIsDeletedFalse() {
        final int userId = 100000;
        final int feedThreadId = 1000;
        final PageRequest pageRequest = PageUtil.sortPageable(new Sort(DESC, "feedThreadId"));
        List<FeedThread> feedThreads = repository.findByUserIdAndFeedThreadIdLessThanAndIsDeletedFalse(userId, feedThreadId, pageRequest);
        System.out.println(feedThreads);
    }
}
