package com.rsoi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "\"User\"")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 50, nullable = false, unique = true)
    private String login;

    @Column(length = 255, nullable = false)
    private String fullName;

    @Column(columnDefinition = "TEXT")
    private String address;

    @Column(length = 20, nullable = false)
    private String phone;

    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}

