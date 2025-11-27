package com.rsoi.service.dto.book;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

@Data
public class BookDto {
    private Long id;
    private String title;
    private String author;
    private String isbn;
    private Integer pageCount;
    private BigDecimal price;
    private LocalDate publicationYear;
    private Integer stock;
    private Set<GenreDto> genres;
}
