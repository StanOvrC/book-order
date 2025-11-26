package com.rsoi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 255, nullable = false)
    private String title;

    @Column(length = 13, nullable = false, unique = true)
    private String isbn;

    @Column(nullable = false)
    private Double price;

    @Column(name = "publication_year", nullable = false)
    private Integer publicationYear;

    @Column(columnDefinition = "TEXT")
    private String annotation;

    @Column(nullable = false)
    private Double weight;

    @OneToOne(mappedBy = "book", cascade = CascadeType.ALL)
    private Warehouse warehouse;

    @ManyToMany
    @JoinTable(
            name = "BookGenre",
            joinColumns = @JoinColumn(name = "bookId"),
            inverseJoinColumns = @JoinColumn(name = "genreId")
    )
    private List<Genre> genres;

    @ManyToMany
    @JoinTable(
            name = "Authorship",
            joinColumns = @JoinColumn(name = "bookId"),
            inverseJoinColumns = @JoinColumn(name = "authorId")
    )
    private List<Author> authors;

    // getters/setters
}

