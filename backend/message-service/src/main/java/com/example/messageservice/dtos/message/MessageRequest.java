package com.example.messageservice.dtos.message;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MessageRequest {
    private String message;
    private Long tripId;
}
