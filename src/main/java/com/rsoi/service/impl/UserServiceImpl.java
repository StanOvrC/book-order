package com.rsoi.service.impl;

import com.rsoi.entity.Role;
import com.rsoi.entity.User;
import com.rsoi.repository.UserRepository;
import com.rsoi.service.UserService;
import com.rsoi.service.dto.user.UserDto;
import com.rsoi.service.dto.user.UserRegisterDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService, UserDetailsService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ModelMapper modelMapper;

    @Override
    public UserDto registerUser(UserRegisterDto registerDto) {
        if (userRepository.findByEmail(registerDto.getEmail()).isPresent()) {
            throw new IllegalArgumentException("User with this email already exists.");
        }
        User user = modelMapper.map(registerDto, User.class);
        String encodedPassword = passwordEncoder.encode(registerDto.getPassword());
        user.setPassword(encodedPassword);
        user.setRole(Role.USER);

        User savedUser = userRepository.save(user);
        return modelMapper.map(savedUser, UserDto.class);
    }

    @Override
    public UserDto findById(Long id) {
        return modelMapper.map(userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User with id " + id + " not found")), UserDto.class);
    }

    @Override
    public UserDto findByEmail(String email) {
        return modelMapper.map(userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User with email " + email + " not found")), UserDto.class);
    }

    @Override
    public UserDto getCurrentUser() {
        String email = Objects.requireNonNull(SecurityContextHolder.getContext().getAuthentication()).getName();

        return findByEmail(email);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + email));

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(user.getRole().getAuthority())
                .build();
    }
}
