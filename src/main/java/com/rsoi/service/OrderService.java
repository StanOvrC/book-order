package com.rsoi.service;

import com.rsoi.entity.Status;
import com.rsoi.service.dto.order.CartActionDto;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.order.OrderSearchCriteria;
import com.rsoi.service.dto.user.UserDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderService {
    OrderDto getOrCreateCart(UserDto user);

    OrderDto addItemToCart(UserDto user, CartActionDto cartActionDto);

    OrderDto decreaseItemQuantity(UserDto user, CartActionDto cartActionDto);

    OrderDto removeItemFromCart(UserDto user, Long orderItemId);

    OrderDto clearCart(UserDto user);

    OrderDto checkout(UserDto user, String address);

    List<OrderDto> getUserOrderHistory(UserDto user);

    List<OrderDto> getAll();

    void updateOrderStatus(Long orderId, Status status);

    Page<OrderDto> searchOrders(OrderSearchCriteria criteria, Pageable pageable);
}
