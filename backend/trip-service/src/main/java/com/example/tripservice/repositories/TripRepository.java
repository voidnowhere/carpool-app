package com.example.tripservice.repositories;

import com.example.tripservice.dtos.TripResponse;
import com.example.tripservice.entities.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {
    @Query("""
            select t from Trip t
                join fetch t.departure
                join fetch t.arrival
                left join fetch t.passengers
                where t.dateTime >= now() and t.dateTime <= :dateTime
                    and t.departure.id = :departureCityId and t.arrival.id = :arrivalCityId
            """)
    List<Trip> findAllAvailable(Date dateTime, Long departureCityId, Long arrivalCityId);
}
