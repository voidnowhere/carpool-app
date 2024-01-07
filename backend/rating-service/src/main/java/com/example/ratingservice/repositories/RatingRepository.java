package com.example.ratingservice.repositories;

import com.example.ratingservice.entities.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Long> {
    boolean existsByRaterIdAndRatedId(UUID raterId, UUID ratedId);

    @Query("""
            select avg(r.value) from Rating r
                where r.ratedId = :userId
                group by r.ratedId
            """)
    Float getAvgRatingOfUserId(UUID userId);
}
