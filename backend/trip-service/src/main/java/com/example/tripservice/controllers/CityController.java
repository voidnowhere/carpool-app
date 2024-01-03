package com.example.tripservice.controllers;

import com.example.tripservice.entities.City;
import com.example.tripservice.services.CityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cities")
@RequiredArgsConstructor
public class CityController {
    private final CityService service;

    @GetMapping
    public ResponseEntity<List<City>> getAll() {
        return service.getAll();
    }
}
