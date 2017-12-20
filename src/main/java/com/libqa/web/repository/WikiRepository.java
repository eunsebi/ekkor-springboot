package com.libqa.web.repository;

import com.libqa.web.domain.Wiki;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yong on 15. 2. 8..
 */
@Repository
public interface WikiRepository extends JpaRepository<Wiki, Integer> {

    Wiki findByWikiIdAndIsDeleted(Integer wikiId, boolean isDeleted);

    List<Wiki> findAllByIsDeleted(Sort orders, boolean isDeleted);

    List<Wiki> findAllByIsDeleted(boolean isDeleted, Pageable pageable);

    List<Wiki> findAllByUserIdAndIsDeleted(Integer userId, boolean isDeleted, Pageable pageable);

    List<Wiki> findBySpaceIdAndIsDeleted(Integer spaceId, boolean isDeleted);

    List<Wiki> findAllBySpaceIdAndIsDeleted(Integer spaceId, boolean isDeleted, Pageable pageable);

    List<Wiki> findAllBySpaceIdAndIsDeleted(Integer spaceId, boolean isDeleted, Sort sort);

    List<Wiki> findAllByWikiIdInAndIsDeleted(List<Integer> wikiIds, boolean isDeleted, Pageable pageable);

    List<Wiki> findAllByContentsMarkupContainingAndIsDeleted(String contentsMarkup, boolean isDeleted, Pageable pageable);

    List<Wiki> findAllByIsDeletedFalse(Pageable pageable);

    List<Wiki> findByParentsIdAndDepthIdxAndIsDeleted(Integer parentsId, Integer depthIdx, boolean isDeleted, Pageable pageable);

    List<Wiki> findByGroupIdxAndOrderIdxGreaterThanEqualAndIsDeleted(Integer groupIdx, Integer orderIdx, boolean isDeleted);

    List<Wiki> findAllBySpaceIdAndIsDeletedFalse(Pageable pageable, Integer spaceId);

    Page<Wiki> findPagingByIsDeleted(Pageable pageable, boolean isDeleted);

    @Query(value = "SELECT w.* FROM wiki w " +
            "WHERE w.is_deleted = 0 " +
            "   AND (w.title LIKE CONCAT('%',:searchValue,'%') OR w.contents_markup LIKE CONCAT('%',:searchValue,'%') ) " +
            "ORDER BY w.wiki_id DESC", nativeQuery = true)
    List<Wiki> findAllBySearchValue(@Param("searchValue") String searchValue);

}