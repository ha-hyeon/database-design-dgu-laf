package com.dgulaf.dgulaf.repository;

import com.dgulaf.dgulaf.model.User;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // 유저네임으로 유저 찾기
    @Query("SELECT u FROM User u WHERE u.userId = :userId")
    Optional<User> findById(int userId);
}