package com.rsoi.service;

import com.rsoi.service.dto.user.UserDto;
import com.rsoi.service.dto.user.UserRegisterDto;

public interface UserService {
    UserDto registerUser(UserRegisterDto registerDto);

    UserDto findById(Long id);

    UserDto findByEmail(String email);

    UserDto getCurrentUser();
}
