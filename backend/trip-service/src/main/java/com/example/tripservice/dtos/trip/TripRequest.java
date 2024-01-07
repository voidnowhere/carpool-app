package com.example.tripservice.dtos.trip;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class TripRequest {
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "UTC")
    private Date dateTime;
    private int seats;
    private Long departureCityId;
    private Long arrivalCityId;
}
