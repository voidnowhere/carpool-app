package com.example.tripservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Entity
@Table(indexes = {@Index(unique = true, columnList = "user_id, trip_id")})
@Getter
@Setter
@NoArgsConstructor
public class Passenger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private UUID userId;
    @ManyToOne(optional = false)
    private Trip trip;

    public Passenger(UUID userId, Trip trip) {
        this.userId = userId;
        this.trip = trip;
    }
}
