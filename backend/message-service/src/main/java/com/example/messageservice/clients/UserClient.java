package com.example.messageservice.clients;

import com.example.messageservice.dtos.user.UserResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.UUID;

@FeignClient("AUTH-SERVICE")
public interface UserClient {
    @GetMapping(path = "/api/users/{id}")
    UserResponse get(@PathVariable UUID id);
}
