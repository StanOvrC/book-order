package com.rsoi.service.impl;

import com.rsoi.entity.Genre;
import com.rsoi.repository.GenreRepository;
import com.rsoi.service.GenreService;
import com.rsoi.service.dto.book.GenreDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GenreServiceImpl implements GenreService {
    private final GenreRepository genreRepository;
    private final ModelMapper modelMapper;

    @Override
    public Optional<GenreDto> findById(Long id) {
        return genreRepository.findById(id)
                .map(genre -> modelMapper.map(genre, GenreDto.class));
    }

    @Override
    public Set<GenreDto> findAll() {
        return genreRepository.findAll().stream()
                .map(genre -> modelMapper.map(genre, GenreDto.class))
                .collect(Collectors.toSet());
    }

    @Override
    public Set<Genre> findByIds(Set<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return Set.of();
        }

        List<Genre> foundGenres = genreRepository.findAllById(ids);

        if (foundGenres.size() != ids.size()) {
            Set<Long> foundIds = foundGenres.stream()
                    .map(Genre::getId)
                    .collect(Collectors.toSet());

            String missingIds = ids.stream()
                    .filter(id -> !foundIds.contains(id))
                    .map(String::valueOf)
                    .collect(Collectors.joining(", "));

            throw new EntityNotFoundException("No genres found for ID: " + missingIds);
        }

        return Set.copyOf(foundGenres);
    }

    @Transactional
    @Override
    public GenreDto createGenre(String name) {
        if (genreRepository.findByName(name).isPresent()) {
            throw new IllegalArgumentException("Genre with name " + name + " already exists");
        }

        Genre genre = new Genre();
        genre.setName(name);

        Genre savedGenre = genreRepository.save(genre);
        return modelMapper.map(savedGenre, GenreDto.class);
    }
}
