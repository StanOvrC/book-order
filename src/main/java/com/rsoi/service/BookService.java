package com.rsoi.service;

import com.rsoi.service.dto.book.BookCreateUpdateDto;
import com.rsoi.service.dto.book.BookDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface BookService {
    Page<BookDto> findAll(Pageable pageable);

    Optional<BookDto> findById(Long id);

    List<String> findAllGenreNames();

    BookDto createBook(BookCreateUpdateDto createDto);

    BookDto updateBook(Long id, BookCreateUpdateDto updateDto);

    void deleteBook(Long id);

    boolean checkStock(Long bookId, int quantity);

    void deductStock(Long bookId, int quantity);
}