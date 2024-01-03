package com.example.tripservice.services;

import com.example.tripservice.dtos.TripResponse;
import com.example.tripservice.entities.Passenger;
import com.example.tripservice.entities.Trip;
import com.example.tripservice.repositories.PassengerRepository;
import com.example.tripservice.repositories.TripRepository;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.HeaderParam;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TripService {
    private final TripRepository tripRepository;
    private final PassengerRepository passengerRepository;

    public ResponseEntity<String> store(Trip trip) {
        tripRepository.save(trip);
        return ResponseEntity.ok().build();
    }

    public ResponseEntity<List<TripResponse>> getAll(
            Date dateTime,
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
                t.getPassengers().stream().anyMatch(p -> p.getUserId().equals(userId)),
                t.getUserId().equals(userId)
        )).toList();

        return ResponseEntity.ok(tripsResponse);
    }

    public ResponseEntity<String> join(Long tripId, UUID userId) {
        Optional<Trip> optionalTrip = tripRepository.findById(tripId);

        if (optionalTrip.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Trip trip = optionalTrip.get();

        if (trip.getUserId().equals(userId)) {
            return ResponseEntity.badRequest().build();
        }

        if (trip.getPassengers().stream().anyMatch(p -> p.getUserId().equals(userId))) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("already joined");
        }

        if (trip.getDateTime().before(new Date())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("not available");
        }

        if (trip.getSeats() <= trip.getPassengers().size()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("max capacity");
        }

        passengerRepository.save(new Passenger(userId, trip));

        return ResponseEntity.ok().build();
    }

    @Transactional
    public ResponseEntity<String> leave(Long tripId, UUID userId) {
        passengerRepository.deleteByUserIdAndTripId(userId, tripId);
        return ResponseEntity.ok().build();
    }
}
