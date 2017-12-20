package com.libqa.web.repository;

import com.libqa.application.enums.Role;
import com.libqa.web.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by yion on 2015. 1. 25..
 */
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUserEmail(String userEmail);

    //@Query("select user_nick FROM user u WHERE u.user_nick = :userNick")
    User findByUserNick(@Param("userNick") String userNick);

    List<User> findByRoleAndIsDeleted(Role role, boolean isDeleted);

    List<User> findAllByIsDeleted(boolean isDeleted);
}
