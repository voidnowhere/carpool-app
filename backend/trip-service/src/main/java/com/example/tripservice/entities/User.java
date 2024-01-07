package com.example.tripservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class User {
    @Id
    private UUID id;
    @Column(nullable = false)
    private String name;
    @Column(unique = true, nullable = false)
    private String email;
    @OneToMany(mappedBy = "driver")
    private List<Trip> trips;

    public User(UUID id) {
        this.id = id;
    }

    public User(UUID id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
    }
}
