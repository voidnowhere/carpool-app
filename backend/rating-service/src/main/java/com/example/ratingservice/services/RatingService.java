package com.example.ratingservice.services;

import com.example.ratingservice.entities.Rating;
import com.example.ratingservice.repositories.RatingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RatingService {
    private final RatingRepository repository;

    public ResponseEntity<String> store(Rating rating) {
        if (rating.getValue() > 5) {
            return ResponseEntity.badRequest().build();
        }

        Optional<Rating> optionalRating = repository.findByRaterIdAndRatedId(rating.getRaterId(), rating.getRatedId());

        if (optionalRating.isEmpty()) {
            repository.save(rating);
        } else {
            Rating existedRating = optionalRating.get();
            existedRating.setValue(rating.getValue());
            repository.save(existedRating);
        }

        return ResponseEntity.ok().build();
    }

    public ResponseEntity<Float> getAvgRating(UUID userId) {
        Float value = repository.getAvgRatingOfUserId(userId);
        float rate = 0;
        if (value != null) {
            rate = value;
        }
        return ResponseEntity.ok(rate);
    }
}
