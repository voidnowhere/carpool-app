package com.example.tripservice.services;

import com.example.tripservice.clients.UserClient;
import com.example.tripservice.dtos.user.UserResponse;
import com.example.tripservice.entities.User;
import com.example.tripservice.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repository;
    private final UserClient userClient;

    public User syncUser(UUID userId) {
        UserResponse userResponse = userClient.get(userId);
        Optional<User> optionalUser = repository.findById(userId);

        User user;

        if (optionalUser.isEmpty()) {
            user = new User(userId, userResponse.getName(), userResponse.getEmail());
            repository.save(user);
        } else {
            user = optionalUser.get();
            user.setName(userResponse.getName());
            user.setEmail(userResponse.getEmail());
            repository.save(user);
        }

        return user;
    }
}
