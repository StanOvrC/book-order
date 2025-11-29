package com.rsoi.service.dto.order;

import com.rsoi.entity.Status;
import com.rsoi.service.dto.user.UserDto;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class OrderDto {
    private Long id;
    private UserDto user;
    private BigDecimal totalCost;
    private Status status;
    private List<OrderItemDto> items;
    private String address;
}
