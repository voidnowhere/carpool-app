package com.example.authservice.services;

import com.example.authservice.dtos.login.LoginRequest;
import com.example.authservice.dtos.login.LoginResponse;
import com.example.authservice.dtos.register.RegisterRequest;
import com.example.authservice.entities.User;
import com.example.authservice.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final JWTUtil jwtUtil;
    private final UserRepository repository;

    public ResponseEntity<LoginResponse> login(LoginRequest request) {
        Optional<User> optionalUser = repository.findByEmail(request.getEmail());

        if (optionalUser.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        User user = optionalUser.get();

        if (!BCrypt.checkpw(request.getPassword(), user.getPassword())) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(new LoginResponse(jwtUtil.generate(user.getId().toString())));
    }

    public ResponseEntity<String> register(RegisterRequest request) {
        if (repository.existsByEmail(request.getEmail())) {
            return ResponseEntity.badRequest().build();
        }

        repository.save(new User(
                request.getName(),
                request.getEmail(),
                BCrypt.hashpw(request.getPassword(), BCrypt.gensalt(12))
        ));

        return ResponseEntity.ok().build();
    }
}
