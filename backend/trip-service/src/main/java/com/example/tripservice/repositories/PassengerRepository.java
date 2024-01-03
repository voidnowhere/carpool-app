package com.example.tripservice.repositories;

import com.example.tripservice.entities.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    void deleteByUserIdAndTripId(UUID userId, Long trip_id);
}
