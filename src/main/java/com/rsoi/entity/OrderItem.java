package com.rsoi.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "orderId")
    private Order order;

    @ManyToOne(optional = false)
    @JoinColumn(name = "bookId")
    private Book book;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false)
    private Double priceAtOrder;
}

