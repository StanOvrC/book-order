package com.rsoi.service.impl;

import com.rsoi.entity.Book;
import com.rsoi.entity.Genre;
import com.rsoi.repository.BookRepository;
import com.rsoi.service.BookService;
import com.rsoi.service.GenreService;
import com.rsoi.service.dto.book.BookCreateUpdateDto;
import com.rsoi.service.dto.book.BookDto;
import com.rsoi.service.exception.InsufficientStockException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookRepository bookRepository;
    private final GenreService genreService;
    private final ModelMapper modelMapper;

    @Override
    public Page<BookDto> findAll(Pageable pageable) {
        return bookRepository.findAll(pageable)
                .map(book -> modelMapper.map(book, BookDto.class));
    }

    @Override
    public Optional<BookDto> findById(Long id) {
        return bookRepository.findById(id)
                .map(book -> modelMapper.map(book, BookDto.class));
    }

    @Override
    public List<String> findAllGenreNames() {
        return genreService.findAll().stream()
                .map(Genre::getName)
                .collect(Collectors.toList());
    }

    @Transactional
    @Override
    public BookDto createBook(BookCreateUpdateDto createDto) {
        Book book = modelMapper.map(createDto, Book.class);

        Set<Genre> genres = genreService.findByIds(createDto.getGenreIds());
        book.setGenres(genres);

        Book savedBook = bookRepository.save(book);
        return modelMapper.map(savedBook, BookDto.class);
    }

    @Transactional
    @Override
    public BookDto updateBook(Long id, BookCreateUpdateDto updateDto) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Book not found with id: " + id));

        modelMapper.map(updateDto, book);

        Set<Genre> genres = genreService.findByIds(updateDto.getGenreIds());
        book.setGenres(genres);

        Book updatedBook = bookRepository.save(book);
        return modelMapper.map(updatedBook, BookDto.class);
    }

    @Transactional
    @Override
    public void deleteBook(Long id) {
        if (!bookRepository.existsById(id)) {
            throw new EntityNotFoundException("Book not found with id: " + id);
        }
        bookRepository.deleteById(id);
    }

    @Override
    public boolean checkStock(Long bookId, int quantity) {
        return bookRepository.findById(bookId)
                .map(book -> book.getStock() >= quantity)
                .orElse(false);
    }

    @Transactional
    @Override
    public void deductStock(Long bookId, int quantity) {
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new EntityNotFoundException("Book not found with id: " + bookId));

        if (book.getStock() < quantity) {
            throw new InsufficientStockException("Insufficient stock for book: " + book.getTitle()
                    + ". Available: " + book.getStock() + ", requested: " + quantity);
        }

        book.setStock(book.getStock() - quantity);
        bookRepository.save(book);
    }
}
