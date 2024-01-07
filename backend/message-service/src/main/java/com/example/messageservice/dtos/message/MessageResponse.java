package com.example.messageservice.dtos.message;

import com.example.messageservice.documents.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class MessageResponse {
    private String message;
    private LocalDateTime dateTime;
    private User user;
}
