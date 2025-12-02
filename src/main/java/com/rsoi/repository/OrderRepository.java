package com.rsoi.repository;

import com.rsoi.entity.Order;
import com.rsoi.entity.Status;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByUserIdAndStatus(Long userId, Status status);

    List<Order> findAllByUserIdAndStatusNot(Long userId, Status status);

    boolean existsByUserIdAndStatus(Long userId, Status status);

    @Query("SELECT o FROM Order o WHERE LOWER(o.user.email) LIKE LOWER(CONCAT('%', :email, '%')) AND o.status <> :status")
    Page<Order> searchByEmail(@Param("email") String email, @Param("status") Status status, Pageable pageable);

    Page<Order> findAllByStatusNot(Status status, Pageable pageable);
}
