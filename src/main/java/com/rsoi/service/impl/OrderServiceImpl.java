package com.rsoi.service.impl;

import com.rsoi.entity.Book;
import com.rsoi.entity.Order;
import com.rsoi.entity.OrderItem;
import com.rsoi.entity.Status;
import com.rsoi.repository.BookRepository;
import com.rsoi.repository.OrderItemRepository;
import com.rsoi.repository.OrderRepository;
import com.rsoi.repository.UserRepository;
import com.rsoi.service.BookService;
import com.rsoi.service.OrderService;
import com.rsoi.service.dto.order.CartActionDto;
import com.rsoi.service.dto.order.OrderDto;
import com.rsoi.service.dto.user.UserDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;
    private final BookRepository bookRepository;
    private final UserRepository userRepository;
    private final OrderItemRepository orderItemRepository;
    private final BookService bookService;
    private final ModelMapper modelMapper;

    private Order getCartEntity(UserDto user) {
        return orderRepository.findByUserIdAndStatus(user.getId(), Status.IN_CART)
                .orElseGet(() -> {
                    Order newOrder = new Order();
                    newOrder.setUser(userRepository.findByEmail(user.getEmail())
                            .orElseThrow(() -> new EntityNotFoundException("User not found with email: " + user.getEmail())));
                    newOrder.setStatus(Status.IN_CART);
                    newOrder.setTotalCost(BigDecimal.ZERO);
                    newOrder.setItems(new ArrayList<>());
                    return orderRepository.save(newOrder);
                });
    }

    @Transactional
    @Override
    public OrderDto getOrCreateCart(UserDto user) {
        Order order = getCartEntity(user);
        return modelMapper.map(order, OrderDto.class);
    }

    @Transactional
    @Override
    public OrderDto addItemToCart(UserDto user, CartActionDto cartActionDto) {
        Order cart = getCartEntity(user);

        Book book = bookRepository.findById(cartActionDto.getBookId())
                .orElseThrow(() -> new EntityNotFoundException("Book not found with id: " + cartActionDto.getBookId()));

        if (!bookService.checkStock(book.getId(), cartActionDto.getQuantity())) {
            throw new IllegalArgumentException("Not enough stock for book: " + book.getTitle());
        }

        Optional<OrderItem> existingItem = cart.getItems().stream()
                .filter(item -> item.getBook().getId().equals(book.getId()))
                .findFirst();

        if (existingItem.isPresent()) {
            OrderItem item = existingItem.get();
            item.setQuantity(item.getQuantity() + cartActionDto.getQuantity());
            item.setPrice(book.getPrice());
        } else {
            OrderItem newItem = new OrderItem();
            newItem.setBook(book);
            newItem.setOrder(cart);
            newItem.setQuantity(cartActionDto.getQuantity());
            newItem.setPrice(book.getPrice());
            cart.getItems().add(newItem);
        }

        calculateTotal(cart);
        Order savedCart = orderRepository.save(cart);
        return modelMapper.map(savedCart, OrderDto.class);
    }

    @Transactional
    @Override
    public OrderDto decreaseItemQuantity(UserDto user, CartActionDto cartActionDto) {
        Order cart = getCartEntity(user);

        OrderItem itemToDecrease = cart.getItems().stream()
                .filter(item -> item.getBook().getId().equals(cartActionDto.getBookId()))
                .findFirst()
                .orElseThrow(() -> new EntityNotFoundException("Item not found in cart"));

        int newQuantity = itemToDecrease.getQuantity() - cartActionDto.getQuantity();

        if (newQuantity <= 0) {
            cart.getItems().remove(itemToDecrease);
            orderItemRepository.delete(itemToDecrease);
        } else {
            itemToDecrease.setQuantity(newQuantity);
        }

        calculateTotal(cart);
        Order savedCart = orderRepository.save(cart);
        return modelMapper.map(savedCart, OrderDto.class);
    }

    @Transactional
    @Override
    public OrderDto removeItemFromCart(UserDto user, Long orderItemId) {
        Order cart = getCartEntity(user);

        OrderItem itemToRemove = cart.getItems().stream()
                .filter(item -> item.getId().equals(orderItemId))
                .findFirst()
                .orElseThrow(() -> new EntityNotFoundException("Item not found in cart"));

        cart.getItems().remove(itemToRemove);
        orderItemRepository.delete(itemToRemove);

        calculateTotal(cart);
        Order savedCart = orderRepository.save(cart);
        return modelMapper.map(savedCart, OrderDto.class);
    }

    @Transactional
    @Override
    public OrderDto clearCart(UserDto user) {
        Order cart = getCartEntity(user);

        if (!cart.getItems().isEmpty()) {
            orderItemRepository.deleteAll(cart.getItems());
            cart.getItems().clear();
        }

        calculateTotal(cart);
        Order savedCart = orderRepository.save(cart);
        return modelMapper.map(savedCart, OrderDto.class);
    }

    private Order calculateTotal(Order order) {
        BigDecimal total = BigDecimal.ZERO;
        if (order.getItems() != null) {
            for (OrderItem item : order.getItems()) {
                BigDecimal itemTotal = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                total = total.add(itemTotal);
            }
        }
        order.setTotalCost(total);
        return order;
    }

    @Transactional
    @Override
    public OrderDto checkout(UserDto user, String address) {
        Order cart = getCartEntity(user);

        if (cart.getItems().isEmpty()) {
            throw new IllegalStateException("Cannot checkout empty cart");
        }

        for (OrderItem item : cart.getItems()) {
            bookService.deductStock(item.getBook().getId(), item.getQuantity());
        }

        cart.setAddress(address);
        cart.setStatus(Status.PENDING);

        Order savedOrder = orderRepository.save(cart);
        return modelMapper.map(savedOrder, OrderDto.class);
    }

    @Override
    public List<OrderDto> getUserOrderHistory(UserDto user) {
        return orderRepository.findAllByUserIdAndStatusNot(user.getId(), Status.IN_CART)
                .stream()
                .map(order -> modelMapper.map(order, OrderDto.class))
                .collect(Collectors.toList());
    }
}
