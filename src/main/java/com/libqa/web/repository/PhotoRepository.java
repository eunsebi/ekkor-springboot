package com.libqa.web.repository;

import java.util.List;

import com.libqa.web.domain.Photo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Created by yion on 15. 2. 8..
 */
public interface PhotoRepository extends JpaRepository<Photo, Integer> {


    List<Photo> findAllByIsDeleted(Sort orders, boolean isDeleted);

    Page<Photo> findPagingByIsDeleted(Pageable pageable, boolean isDeleted);

    @Query(value = "SELECT s.* FROM photo s " +
            "WHERE s.is_deleted = 0 " +
            "   AND (s.title LIKE CONCAT('%',:searchValue,'%') OR s.description_markup LIKE CONCAT('%',:searchValue,'%') ) " +
            "ORDER BY s.space_id DESC", nativeQuery = true)
    List<Photo> findAllBySearchValue(@Param("searchValue") String searchValue);
}
