package com.rsoi.service;

import com.rsoi.entity.Genre;
import com.rsoi.service.dto.book.GenreDto;

import java.util.Optional;
import java.util.Set;

public interface GenreService {
    Optional<GenreDto> findById(Long id);

    Set<GenreDto> findAll();

    Set<Genre> findByIds(Set<Long> ids);

    GenreDto createGenre(String name);
}
