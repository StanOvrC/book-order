package com.rsoi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false, unique = true)
    private String fullName;

    @Column(columnDefinition = "TEXT")
    private String biography;

    @ManyToMany(mappedBy = "authors")
    private List<Book> books;
}

