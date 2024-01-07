package com.example.ratingservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Entity
@Table(indexes = {@Index(unique = true, columnList = "rater_id, rated_id")})
@Getter
@Setter
@NoArgsConstructor
public class Rating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private byte value;
    @Column(nullable = false)
    private UUID raterId;
    @Column(nullable = false)
    private UUID ratedId;

    public Rating(byte value, UUID raterId, UUID ratedId) {
        this.value = value;
        this.raterId = raterId;
        this.ratedId = ratedId;
    }
}
