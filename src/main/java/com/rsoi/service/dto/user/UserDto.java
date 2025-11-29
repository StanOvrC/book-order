package com.rsoi.service.dto.user;

import com.rsoi.entity.Role;
import lombok.Data;

import java.time.LocalDate;

@Data
public class UserDto {
    private Long id;
    private String firstName;
    private String lastName;
    private Role role;
    private LocalDate birthdate;
    private String email;
}
