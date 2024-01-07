package com.example.tripservice.services;

import com.example.tripservice.clients.UserClient;
import com.example.tripservice.dtos.trip.Driver;
import com.example.tripservice.dtos.trip.TripResponse;
import com.example.tripservice.dtos.user.UserResponse;
import com.example.tripservice.entities.Passenger;
import com.example.tripservice.entities.Trip;
import com.example.tripservice.entities.User;
import com.example.tripservice.repositories.PassengerRepository;
import com.example.tripservice.repositories.TripRepository;
import com.example.tripservice.repositories.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TripService {
    private final TripRepository tripRepository;
    private final PassengerRepository passengerRepository;
    private final UserRepository userRepository;
    private final UserClient userClient;

    public ResponseEntity<String> store(Trip trip) {
        UUID userId = trip.getDriver().getId();
        UserResponse userResponse = userClient.get(userId);
        Optional<User> optionalUser = userRepository.findById(userId);

        if (optionalUser.isEmpty()) {
            userRepository.save(new User(userId, userResponse.getName(), userResponse.getEmail()));
        } else {
            User user = optionalUser.get();
            user.setName(userResponse.getName());
            user.setEmail(userResponse.getEmail());
            userRepository.save(user);
        }

        tripRepository.save(trip);
        return ResponseEntity.ok().build();
    }

    public ResponseEntity<List<TripResponse>> getAll(
            LocalDateTime dateTime,
            Long departureCityId,
            Long arrivalCityId,
            UUID userId
    ) {
        List<Trip> trips = tripRepository.findAllAvailable(dateTime, departureCityId, arrivalCityId);

        List<TripResponse> tripsResponse = trips.stream().map(t -> new TripResponse(
                t.getId(),
                t.getDateTime(),
                t.getSeats() - t.getPassengers().size(),
                t.getDeparture(),
                t.getArrival(),
                t.getPassengers().stream().anyMatch(p -> p.getUser().getId().equals(userId)),
                t.getDriver().getId().equals(userId),
                new Driver(t.getDriver().getId(), t.getDriver().getName())
        )).toList();

        return ResponseEntity.ok(tripsResponse);
    }

    public ResponseEntity<String> join(Long tripId, UUID userId) {
        Optional<Trip> optionalTrip = tripRepository.findById(tripId);

        if (optionalTrip.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Trip trip = optionalTrip.get();

        if (trip.getDriver().getId().equals(userId)) {
            return ResponseEntity.badRequest().build();
        }

        if (trip.getPassengers().stream().anyMatch(p -> p.getUser().getId().equals(userId))) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("already joined");
        }

        if (trip.getDateTime().isBefore(LocalDateTime.now())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("not available");
        }

        if (trip.getSeats() <= trip.getPassengers().size()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("max capacity");
        }

        passengerRepository.save(new Passenger(new User(userId), trip));

        return ResponseEntity.ok().build();
    }

    @Transactional
    public ResponseEntity<String> leave(Long tripId, UUID userId) {
        passengerRepository.deleteByUserIdAndTripId(userId, tripId);
        return ResponseEntity.ok().build();
    }
}
