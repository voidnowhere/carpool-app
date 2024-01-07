package com.example.authservice.dtos.profile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ProfileResponse {
    private String name;
    private String email;
}
