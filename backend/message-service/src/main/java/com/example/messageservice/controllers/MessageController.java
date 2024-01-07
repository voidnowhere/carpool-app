package com.example.messageservice.controllers;

import com.example.messageservice.documents.Message;
import com.example.messageservice.documents.User;
import com.example.messageservice.dtos.message.MessageRequest;
import com.example.messageservice.dtos.message.MessageResponse;
import com.example.messageservice.services.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("api/messages")
@RequiredArgsConstructor
public class MessageController {
    private final MessageService service;

    @PostMapping
    public ResponseEntity<String> store(
            @RequestBody MessageRequest request,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.store(new Message(
                UUID.randomUUID(),
                request.getMessage(),
                request.getTripId(),
                LocalDateTime.now(),
                new User(userId)
        ));
    }

    @GetMapping("/trips/{id}")
    public ResponseEntity<List<MessageResponse>> getAll(@PathVariable Long id) {
        return service.getAll(id);
    }
}
