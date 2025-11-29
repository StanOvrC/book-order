package com.rsoi.service;

import com.rsoi.entity.User;
import com.rsoi.service.dto.user.UserDto;
import com.rsoi.service.dto.user.UserRegisterDto;

import java.util.Optional;

public interface UserService {
    UserDto registerUser(UserRegisterDto registerDto);

    Optional<User> findById(Long id);

    Optional<User> findByEmail(String email);

    User getCurrentUser();
}
