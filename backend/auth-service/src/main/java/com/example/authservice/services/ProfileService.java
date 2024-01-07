package com.example.authservice.services;

import com.example.authservice.dtos.profile.ProfileRequest;
import com.example.authservice.dtos.profile.ProfileResponse;
import com.example.authservice.entities.User;
import com.example.authservice.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProfileService {
    private final UserRepository repository;

    public ResponseEntity<ProfileResponse> get(UUID userId) {
        Optional<User> optionalUser = repository.findById(userId);

        if (optionalUser.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        User user = optionalUser.get();
        return ResponseEntity.ok(new ProfileResponse(user.getName(), user.getEmail()));
    }

    public ResponseEntity<ProfileResponse> update(UUID userId, ProfileRequest request) {
        Optional<User> optionalUser = repository.findById(userId);

        if (optionalUser.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        User user = optionalUser.get();

        if (!BCrypt.checkpw(request.getPassword(), user.getPassword())) {
            return ResponseEntity.badRequest().build();
        }

        user.setName(request.getName());
        user.setEmail(request.getEmail());

        repository.save(user);

        return ResponseEntity.ok().build();
    }
}
