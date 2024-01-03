package com.example.tripservice.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date dateTime;
    private int seats;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private City departure;
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private City arrival;
    @Column(nullable = false)
    private UUID userId;
    @OneToMany(mappedBy = "trip")
    private List<Passenger> passengers;

    public Trip(Date dateTime, int seats, City departure, City arrival, UUID userId) {
        this.dateTime = dateTime;
        this.seats = seats;
        this.departure = departure;
        this.arrival = arrival;
        this.userId = userId;
    }
}
