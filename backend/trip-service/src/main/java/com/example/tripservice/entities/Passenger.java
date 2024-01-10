package com.example.tripservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(indexes = {@Index(unique = true, columnList = "user_id, trip_id")})
@Getter
@Setter
@NoArgsConstructor
public class Passenger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User user;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Trip trip;

    public Passenger(User user, Trip trip) {
        this.user = user;
        this.trip = trip;
    }
}
