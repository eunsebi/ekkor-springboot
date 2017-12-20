package com.libqa.web.service.user;

import com.libqa.application.exception.UserNotCreateException;
import com.libqa.web.domain.Keyword;
import com.libqa.web.domain.User;
import com.libqa.web.view.user.UserList;

/**
 * @Author : yion
 * @Date : 2015. 4. 12.
 * @Description :
 */
public interface UserService {
    /**
     * 회원 가입 (사용자 계정 생성)
     *
     * @param userEmail
     * @param userNick
     * @param password
     * @param loginType
     * @return
     * @throws UserNotCreateException
     */
    User createUser(String userEmail, String userNick, String password, String loginType) throws UserNotCreateException;

    /**
     * 인증 여부 업데이트
     *
     * @param userId
     * @param certificationKey
     * @return
     * @throws UserNotCreateException
     */
    int updateForCertificationByKey(Integer userId, Integer certificationKey) throws UserNotCreateException;

    /**
     * 이메일 중복 확인
     *
     * @param userEmail
     * @return
     */
    User findByEmail(String userEmail);

    /**
     * 닉네임 중복 확인
     *
     * @param userNick
     * @return
     */
    User findByNick(String userNick);

    /**
     * 로그인 처리 (인증 여부 검사)
     *
     * @param email
     * @return
     */
    User findByEmailAndIsCertification(String email);

    /**
     * userId로 사용자 조회
     * @param userId
     * @return
     */
    User findByUserId(Integer userId);

    /**
     * 최종 방문일 수정
     * @param email
     */
    void updateUserLastVisitDate(String email);

    /**
     * 회원 정보 수정 및 키워드 추가
     * @param user
     * @return
     */
    User updateUserProfileAndKeyword(User user, Keyword keyword);

    /**
     * 전체 회원 목록
     * @param sortType
     * @return
     */
    UserList findAllUserPageBySort(String sortType);
}
