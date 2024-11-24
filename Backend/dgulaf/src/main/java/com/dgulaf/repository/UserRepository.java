package com.dgulaf.repository;

import com.dgulaf.model.User;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // 유저네임으로 유저 찾기
    Optional<User> findById(int userId);
}
