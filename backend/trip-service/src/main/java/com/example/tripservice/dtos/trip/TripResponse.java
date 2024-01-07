package com.example.tripservice.dtos.trip;

import com.example.tripservice.entities.City;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TripResponse {
    private Long id;
    private LocalDateTime dateTime;
    private int seats;
    private City departure;
    private City arrival;
    private boolean joined;
    private boolean owner;
    private Driver driver;
}
