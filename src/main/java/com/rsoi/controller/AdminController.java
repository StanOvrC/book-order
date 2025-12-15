package com.rsoi.controller;

import com.rsoi.entity.Status;
import com.rsoi.service.BookService;
import com.rsoi.service.GenreService;
import com.rsoi.service.OrderService;
import com.rsoi.service.dto.book.BookCreateUpdateDto;
import com.rsoi.service.dto.book.BookDto;
import com.rsoi.service.dto.book.GenreDto;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.order.OrderSearchCriteria;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {
    private final BookService bookService;
    private final GenreService genreService;
    private final OrderService orderService;

    @GetMapping("/books/new")
    public String newBookForm(Model model) {
        model.addAttribute("book", new BookCreateUpdateDto());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("isEdit", false);
        return "admin/book-form";
    }

    @PostMapping("/books/new")
    public String createBook(@ModelAttribute @Valid BookCreateUpdateDto createDto,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("genres", genreService.findAll());
            model.addAttribute("isEdit", false);
            return "admin/book-form";
        }
        bookService.createBook(createDto);
        redirectAttributes.addFlashAttribute("successMessage", "Книга успешно создана");
        return "redirect:/books";
    }

    @GetMapping("/books/{id}/edit")
    public String editBookForm(@PathVariable Long id, Model model) {
        BookDto book = bookService.findById(id)
                .orElseThrow(() -> new RuntimeException("Book not found"));

        BookCreateUpdateDto dto = new BookCreateUpdateDto();
        dto.setTitle(book.getTitle());
        dto.setAuthor(book.getAuthor());
        dto.setIsbn(book.getIsbn());
        dto.setPageCount(book.getPageCount());
        dto.setPrice(book.getPrice());
        dto.setPublicationYear(book.getPublicationYear());
        dto.setStock(book.getStock());
        dto.setDescription(book.getDescription());

        dto.setGenreIds(
                book.getGenres()
                        .stream()
                        .map(GenreDto::getId)
                        .collect(Collectors.toSet())
        );

        model.addAttribute("book", dto);
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("isEdit", true);

        model.addAttribute("currentImagePath", book.getImagePath());

        return "admin/book-form";
    }

    @PostMapping("/books/{id}/edit")
    public String updateBook(@PathVariable Long id,
                             @ModelAttribute @Valid BookCreateUpdateDto updateDto,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("genres", genreService.findAll());
            model.addAttribute("isEdit", true);
            return "admin/book-form";
        }
        bookService.updateBook(id, updateDto);
        redirectAttributes.addFlashAttribute("successMessage", "Книга обновлена");
        return "redirect:/books";
    }

    @PostMapping("/books/{id}/delete")
    public String deleteBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            bookService.deleteBook(id);
            redirectAttributes.addFlashAttribute("successMessage", "Книга удалена");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Нельзя удалить книгу, так как с ней связаны заказы");
        }
        return "redirect:/books";
    }

    @GetMapping("/orders")
    public String listOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @ModelAttribute OrderSearchCriteria criteria,
            Model model
    ) {
        Page<OrderDto> ordersPage = orderService.searchOrders(criteria, PageRequest.of(page, size));

        model.addAttribute("ordersPage", ordersPage);
        model.addAttribute("criteria", criteria);

        model.addAttribute("statuses", Status.values());

        return "admin/orders";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(@PathVariable Long id,
                                    @RequestParam("status") String status,
                                    RedirectAttributes redirectAttributes) {
        orderService.updateOrderStatus(id, Status.valueOf(status));
        redirectAttributes.addFlashAttribute("successMessage", "Статус заказа #" + id + " обновлен");
        return "redirect:/admin/orders";
    }
}