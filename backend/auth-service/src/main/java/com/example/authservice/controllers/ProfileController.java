package com.example.authservice.controllers;

import com.example.authservice.dtos.profile.ProfileRequest;
import com.example.authservice.dtos.profile.ProfileResponse;
import com.example.authservice.services.ProfileService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("api/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final ProfileService service;

    @GetMapping
    public ResponseEntity<ProfileResponse> get(@RequestHeader("User-Id") UUID userId) {
        return service.get(userId);
    }

    @PatchMapping
    public ResponseEntity<ProfileResponse> update(
            @RequestBody ProfileRequest request,
            @RequestHeader("User-Id") UUID userId
    ) {
        return service.update(userId, request);
    }
}
