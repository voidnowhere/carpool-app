package com.example.messageservice.services;

import com.example.messageservice.clients.UserClient;
import com.example.messageservice.documents.Message;
import com.example.messageservice.documents.User;
import com.example.messageservice.dtos.message.MessageResponse;
import com.example.messageservice.dtos.user.UserResponse;
import com.example.messageservice.repositories.MessageRepository;
import com.example.messageservice.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MessageService {
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;
    private final UserClient userClient;

    public ResponseEntity<String> store(Message message) {
        UUID userId = message.getUser().getId();
        Optional<User> optionalUser = userRepository.findById(userId);
        UserResponse userResponse = userClient.get(userId);

        if (optionalUser.isEmpty()) {
            userRepository.insert(new User(
                    userId,
                    userResponse.getName(),
                    userResponse.getEmail()
            ));
        } else {
            User user = optionalUser.get();
            user.setName(userResponse.getName());
            user.setEmail(userResponse.getEmail());
            userRepository.save(user);
            message.setUser(user);
        }

        messageRepository.insert(message);
        return ResponseEntity.ok().build();
    }

    public ResponseEntity<List<MessageResponse>> getAll(Long tripId) {
        List<Message> messages = messageRepository.findAllByTripId(tripId);

        if (messages.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(messages.stream()
                .map(m -> new MessageResponse(m.getMessage(), m.getDateTime(), m.getUser())).toList()
        );
    }
}
