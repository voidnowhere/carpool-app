package com.example.tripservice.dtos.trip;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class TripRequest {
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "UTC")
    private LocalDateTime dateTime;
    private int seats;
    private Long departureCityId;
    private Long arrivalCityId;
}
