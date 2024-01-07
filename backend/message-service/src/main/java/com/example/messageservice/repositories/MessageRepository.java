package com.example.messageservice.repositories;

import com.example.messageservice.documents.Message;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface MessageRepository extends MongoRepository<Message, UUID> {
    List<Message> findAllByTripId(Long tripId);
}
