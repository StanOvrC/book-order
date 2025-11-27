package com.rsoi.repository;

import com.rsoi.entity.Order;
import com.rsoi.entity.Status;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByUserIdAndStatus(Long userId, Status status);

    List<Order> findAllByUserIdAndStatusNot(Long userId, Status status);

    boolean existsByUserIdAndStatus(Long userId, Status status);
}
