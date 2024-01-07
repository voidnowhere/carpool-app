package com.example.ratingservice.controllers;

import com.example.ratingservice.dtos.RatingRequest;
import com.example.ratingservice.entities.Rating;
import com.example.ratingservice.services.RatingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("api/ratings")
@RequiredArgsConstructor
public class RatingController {
    private final RatingService service;

    @PatchMapping
    public ResponseEntity<String> store(
            @RequestBody RatingRequest request,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.store(new Rating(request.getValue(), userId, request.getRatedId()));
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<Float> getAvgRating(@PathVariable UUID id) {
        return service.getAvgRating(id);
    }
}
