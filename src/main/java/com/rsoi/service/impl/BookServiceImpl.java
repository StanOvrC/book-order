package com.rsoi.service.impl;

import com.rsoi.entity.Book;
import com.rsoi.entity.Genre;
import com.rsoi.repository.BookRepository;
import com.rsoi.service.BookService;
import com.rsoi.service.GenreService;
import com.rsoi.service.dto.book.BookCreateUpdateDto;
import com.rsoi.service.dto.book.BookDto;
import com.rsoi.service.dto.book.GenreDto;
import com.rsoi.service.exception.InsufficientStockException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookRepository bookRepository;
    private final GenreService genreService;
    private final ModelMapper modelMapper;
    private static final String UPLOAD_DIR = "uploads";

    private String saveImage(MultipartFile image) {
        if (image == null || image.isEmpty()) {
            return null;
        }

        try {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);

            Files.copy(image.getInputStream(), filePath);

            return "/images/uploads/" + fileName;

        } catch (IOException e) {
            throw new RuntimeException("Could not save image", e);
        }
    }

    @Override
    public Page<BookDto> findAll(Pageable pageable) {
        return bookRepository.findAllByIsDeletedFalse(pageable)
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
                .map(GenreDto::getName)
                .collect(Collectors.toList());
    }

    @Transactional
    @Override
    public BookDto createBook(BookCreateUpdateDto createDto) {
        Book book = modelMapper.map(createDto, Book.class);

        String imagePath = saveImage(createDto.getImage());
        if (imagePath != null) {
            book.setImagePath(imagePath);
        }

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

        book.setTitle(updateDto.getTitle());
        book.setAuthor(updateDto.getAuthor());
        book.setIsbn(updateDto.getIsbn());
        book.setPageCount(updateDto.getPageCount());
        book.setPrice(updateDto.getPrice());
        book.setPublicationYear(updateDto.getPublicationYear());
        book.setStock(updateDto.getStock());

        if (updateDto.getImage() != null && !updateDto.getImage().isEmpty()) {
            String newImagePath = saveImage(updateDto.getImage());
            book.setImagePath(newImagePath);
        }

        Set<Genre> newGenres = genreService.findByIds(updateDto.getGenreIds());
        book.getGenres().clear();
        book.getGenres().addAll(newGenres);

        Book updatedBook = bookRepository.save(book);
        return modelMapper.map(updatedBook, BookDto.class);
    }

    @Transactional
    @Override
    public void deleteBook(Long id) {
        Book book = bookRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Book not found with id: " + id));

        book.setDeleted(true);
        book.setStock(0);

        bookRepository.save(book);
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

    @Override
    public Page<BookDto> searchBooks(String query, Pageable pageable) {
        if (query == null || (query = query.trim()).isEmpty()) {
            return bookRepository.findAll(pageable)
                    .map(book -> modelMapper.map(book, BookDto.class));
        }

        return bookRepository.findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCaseAndIsDeletedFalse(
                        query, query, pageable)
                .map(book -> modelMapper.map(book, BookDto.class));
    }

    @Override
    public Page<BookDto> findByGenre(Long genreId, Pageable pageable) {
        if (genreId == null) {
            throw new IllegalArgumentException("Genre ID cannot be null");
        }

        return bookRepository.findByGenres_IdAndIsDeletedFalse(genreId, pageable)
                .map(book -> modelMapper.map(book, BookDto.class));
    }
}