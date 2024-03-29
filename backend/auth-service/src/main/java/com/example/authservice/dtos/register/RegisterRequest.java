package com.example.authservice.dtos.register;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class RegisterRequest {
    private String name;
    private String email;
    private String password;
}
