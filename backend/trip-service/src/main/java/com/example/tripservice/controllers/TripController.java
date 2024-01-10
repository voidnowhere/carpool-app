package com.example.tripservice.controllers;

import com.example.tripservice.dtos.trip.TripRequest;
import com.example.tripservice.dtos.trip.TripResponse;
import com.example.tripservice.entities.City;
import com.example.tripservice.entities.Trip;
import com.example.tripservice.entities.User;
import com.example.tripservice.services.TripService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/trips")
@RequiredArgsConstructor
public class TripController {
    private final TripService service;

    @PostMapping
    public ResponseEntity<String> store(
            @RequestBody TripRequest tripRequest,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.store(new Trip(
                tripRequest.getDateTime(),
                tripRequest.getSeats(),
                new City(tripRequest.getDepartureCityId()),
                new City(tripRequest.getArrivalCityId()),
                new User(userId)
        ));
    }

    @GetMapping
    public ResponseEntity<List<TripResponse>> getAll(
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime dateTime,
            @RequestParam Long departureCityId,
            @RequestParam Long arrivalCityId,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.getAll(dateTime, departureCityId, arrivalCityId, userId);
    }

    @PatchMapping("/{id}/join")
    public ResponseEntity<String> join(
            @PathVariable Long id,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.join(id, userId);
    }

    @PatchMapping("/{id}/leave")
    public ResponseEntity<String> leave(
            @PathVariable Long id,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.leave(id, userId);
    }
}
