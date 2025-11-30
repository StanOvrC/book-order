package com.rsoi.controller;

import com.rsoi.service.BookService;
import com.rsoi.service.GenreService;
import com.rsoi.service.dto.book.BookDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/books")
public class BookController {
    private final BookService bookService;
    private final GenreService genreService;

    @GetMapping
    public String getCatalog(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String query,
            @RequestParam(required = false) Long genre,
            Model model
    ) {

        Page<BookDto> books;

        if (query != null && !query.isBlank()) {
            books = bookService.searchBooks(query, PageRequest.of(page, size));
        } else if (genre != null) {
            books = bookService.findByGenre(genre, PageRequest.of(page, size));
        } else {
            books = bookService.findAll(PageRequest.of(page, size));
        }

        model.addAttribute("books", books);
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("query", query);
        model.addAttribute("selectedGenre", genre);

        return "book/catalog";
    }

    @GetMapping("/{id}")
    public String getBookPage(@PathVariable Long id, Model model) {
        BookDto book = bookService.findById(id)
                .orElseThrow(() -> new RuntimeException("Book not found"));

        model.addAttribute("book", book);
        return "book/details";
    }
}
