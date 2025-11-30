package com.rsoi.service;

import com.rsoi.service.dto.order.CartActionDto;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.user.UserDto;

import java.util.List;

public interface OrderService {
    OrderDto getOrCreateCart(UserDto user);

    OrderDto addItemToCart(UserDto user, CartActionDto cartActionDto);

    OrderDto decreaseItemQuantity(UserDto user, CartActionDto cartActionDto);

    OrderDto removeItemFromCart(UserDto user, Long orderItemId);

    OrderDto clearCart(UserDto user);

    OrderDto checkout(UserDto user, String address);

    List<OrderDto> getUserOrderHistory(UserDto user);
}
