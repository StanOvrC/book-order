package com.rsoi.service.dto.order;

import lombok.Data;

@Data
public class OrderSearchCriteria {
    private String email;
    private Long orderId;
}
