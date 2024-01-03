package com.example.tripservice.services;

import com.example.tripservice.entities.City;
import com.example.tripservice.repositories.CityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CityService {
    private final CityRepository repository;

    public ResponseEntity<List<City>> getAll() {
        List<City> cities = repository.findAll();

        if (cities.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(cities);
    }
}
