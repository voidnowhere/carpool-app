package com.example.tripservice.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.List;

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
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User driver;
    @OneToMany(mappedBy = "trip")
    private List<Passenger> passengers;

    public Trip(Date dateTime, int seats, City departure, City arrival, User driver) {
        this.dateTime = dateTime;
        this.seats = seats;
        this.departure = departure;
        this.arrival = arrival;
        this.driver = driver;
    }
}
