package com.example.authservice.services;

import com.example.authservice.dtos.user.UserResponse;
import com.example.authservice.entities.User;
import com.example.authservice.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repository;

    public ResponseEntity<UserResponse> get(UUID userId) {
        Optional<User> optionalUser = repository.findById(userId);

        if (optionalUser.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        User user = optionalUser.get();

        return ResponseEntity.ok(new UserResponse(user.getName(), user.getEmail()));
    }
}
