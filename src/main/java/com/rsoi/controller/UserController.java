package com.rsoi.controller;

import com.rsoi.service.OrderService;
import com.rsoi.service.UserService;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.user.UserDto;
import com.rsoi.service.dto.user.UserRegisterDto;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {
    private final UserService userService;
    private final OrderService orderService;

    @GetMapping("/login")
    public String loginPage() {
        return "users/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new UserRegisterDto());
        return "users/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute("user") @Valid UserRegisterDto userDto,
                           BindingResult bindingResult,
                           Model model) {

        if (bindingResult.hasErrors()) {
            return "users/register";
        }

        try {
            userService.registerUser(userDto);
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "users/register";
        }

        return "redirect:/users/login?registered=true";
    }

    @GetMapping("/profile")
    public String profilePage(Model model) {
        UserDto user = userService.getCurrentUser();
        model.addAttribute("user", user);

        List<OrderDto> orders = orderService.getUserOrderHistory(user);
        model.addAttribute("orders", orders);

        return "users/profile";
    }
}
