package com.rsoi.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Warehouse {

    @Id
    @Column(name = "bookId")
    private Integer id;

    @OneToOne
    @MapsId
    @JoinColumn(name = "bookId")
    private Book book;

    @Column(nullable = false)
    private Integer quantityInStock = 0;
}

