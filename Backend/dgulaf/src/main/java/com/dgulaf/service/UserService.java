package com.dgulaf.service;

import com.dgulaf.model.User;
import com.dgulaf.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // 사용자 등록
    public User createUser(User user) {
        return userRepository.save(user);
    }

    // user_id로 사용자 조회
    public Optional<User> getUserById(int userId) {
        return userRepository.findById(userId);
    }
}
