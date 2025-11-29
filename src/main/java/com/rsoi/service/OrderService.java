package com.rsoi.service;

import com.rsoi.entity.Order;
import com.rsoi.entity.User;
import com.rsoi.service.dto.order.CartActionDto;
import com.rsoi.service.dto.order.OrderDto;

import java.util.List;

public interface OrderService {
    Order getOrCreateCart(User user);

    OrderDto addItemToCart(User user, CartActionDto cartActionDto);

    OrderDto removeItemFromCart(User user, Long orderItemId);

    OrderDto clearCart(User user);

    Order calculateTotal(Order order);

    OrderDto checkout(User user);

    List<OrderDto> getUserOrderHistory(User user);
}
