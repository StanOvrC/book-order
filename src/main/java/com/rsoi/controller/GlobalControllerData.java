package com.rsoi.controller;

import com.rsoi.service.OrderService;
import com.rsoi.service.UserService;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.order.OrderItemDto;
import com.rsoi.service.dto.user.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerData {

    private final UserService userService;
    private final OrderService orderService;

    @ModelAttribute("cartItemCount")
    public int getCartItemCount() {
        try {
            UserDto user = userService.getCurrentUser();

            if (user == null) {
                return 0;
            }

            OrderDto cart = orderService.getOrCreateCart(user);

            return cart.getItems().stream()
                    .mapToInt(OrderItemDto::getQuantity)
                    .sum();

        } catch (Exception e) {
            return 0;
        }
    }
}
