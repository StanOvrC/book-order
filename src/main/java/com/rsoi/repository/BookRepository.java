package com.rsoi.repository;

import com.rsoi.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Long> {
    Page<Book> findAllByIsDeletedFalse(Pageable pageable);

    Page<Book> findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCaseAndIsDeletedFalse(
            String title, String author, Pageable pageable);

    boolean existsByIdAndIsDeletedFalse(Long id);

    Page<Book> findByGenres_IdAndIsDeletedFalse(Long genreId, Pageable pageable);
}
