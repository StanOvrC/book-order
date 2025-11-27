package com.rsoi.service;

import com.rsoi.entity.Genre;

import java.util.Optional;
import java.util.Set;

public interface GenreService {
    Optional<Genre> findById(Long id);

    Set<Genre> findAll();

    Set<Genre> findByIds(Set<Long> ids);

    Genre createGenre(String name);
}
