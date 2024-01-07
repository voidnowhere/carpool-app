package com.example.gatewayservice.config;

import lombok.RequiredArgsConstructor;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class GatewayConfig {
    private final AuthFilter filter;

    @Bean
    public RouteLocator routes(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("auth-service", r -> r
                        .path("/api/auth/**")
                        .or()
                        .path("/api/profile")
                        .or()
                        .path("/api/users/**")
                        .filters(f -> f.filter(filter))
                        .uri("lb://auth-service")
                ).route("trip-service", r -> r
                        .path("/api/trips/**")
                        .or()
                        .path("/api/cities/**")
                        .filters(f -> f.filter(filter))
                        .uri("lb://trip-service")
                ).route("rating-service", r -> r
                        .path("/api/ratings")
                        .or()
                        .path("/api/ratings/users/**")
                        .filters(f -> f.filter(filter))
                        .uri("lb://rating-service")
                ).route("message-service", r -> r
                        .path("/api/messages")
                        .or()
                        .path("/api/messages/trips/**")
                        .filters(f -> f.filter(filter))
                        .uri("lb://message-service")
                ).build();
    }
}
